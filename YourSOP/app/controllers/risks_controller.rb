class RisksController < ApplicationController

  
  @@risk_likelihood = Hash[ "Rare/Remote (Actual Frequency: Occurs every 5 years or more. Probability: 1%)", 1, "Unlikely (Actual Frequency: Occurs every 2-5 years. Probability: 10%.)", 2, "Possible (Actual Frequency: Occurs every 1-2 years. Probability: 50%)", 3, "Likely (Actual Frequency: Bimonthly. Probability: 75%.)", 4, "Almost Certain (Actual Frequency: At least monthly. Probability: 99%.)", 5 ]
  @@default_risks = ["Injury", "Service User Experience", "Compliance with Standards (Statutory, Clinical, Professional & Management)", "Objectives/Projects", "Business Continuity", "Adverse publicity/ Reputation", "Financial Loss (per local Contact)", "Environment"]


  before_action :check_current_organisation 
  #before_action :check_current_user_is_quality

  def index
    @topics = get_topics
  end

  def new
    @topic = Topic.find(params[:id])
    @documents = @topic.documents
    @risk = Risk.where(topic_id: @topic.id, status: -1).first
    if @risk == nil
      @risk = Risk.new(:topic_id => @topic.id)
      @@default_risks.each do |r|
        @risk.risks_details.build(title: r, impact: 1, likelihood: 1);
      end
    end
    
    @risk.score = 0
    @current_user_id = current_user.id
    @risk_impact = RisksImpact.all
    @risk_likelihood = @@risk_likelihood
  end

  def create
    @topic = Topic.find(risk_params[:topic_id])
    @risk = @topic.risks.build(risk_params)
    if publishing?
      #update previous risks (topic_id = @risk.topic_id) status value 0
      Risk.where(topic_id: @risk.topic_id.to_s).update_all("status = 0") if publishing?
      @risk.organization_id = get_current_organisation.id
      @risk.status = 1

      #if publishing update topic score = risk.score
      @topic.update(score: @risk.score)

      send_message(current_user.id, "You assessed a topic " + @topic.name + ", now its risk score is " + @risk.score.to_s, Time.now.to_s);
    else
      @risk.status = -1
    end

    if @risk.save
      redirect_to risks_path, notice: 'save succeed!'
    else
      @risk = Risk.where(topic_id: @topic.id, status: -1).first
      if @risk == nil
        @risk = Risk.new(:topic_id => @topic.id)
      end
      @risk.risks_details.build
      @risk.score = 0
      @current_user_id = current_user.id
      @risk_impact = RisksImpact.all
      @risk_likelihood = @@risk_likelihood
      render action: 'new', alert: 'save failed!'
    end
  end

  def update
    @risk = Risk.find(params[:id])

    if publishing?
      #update previous risks (topic_id = @risk.topic_id) status value 0
      Risk.where(topic_id: @risk.topic_id.to_s).update_all("status = 0")
      @risk.status = 1

      #if publishing update topic score = risk.score
      @topic = Topic.find(@risk.topic_id)
      @topic.update(score: @risk.score)

      msg = "Publish succeed!"
    else
      msg = "Save succeed!"
    end

    if @risk.update(risk_params)
      redirect_to risks_path, notice: msg
    else
      redirect_to risks_path, alert: "Operation failed!"
    end
  end

  def show
    @topic = Topic.find(params[:id])
    if params[:risk_id] == nil
      @risk = Risk.where(topic_id: @topic.id, status: 1).first
    else
      @risk = Risk.find(params[:risk_id])
    end

    if @risk == nil
      redirect_to risks_path, alert: "Please assess risks first!"
    end

    @history = Risk.where(topic_id: @topic.id, status: 0).select("created_at, id, score")
  end


  private

    def risk_params
      params.require(:risk).permit(:id, :topic_id, :user_id, :desc, :score, risks_details_attributes: [:id, :title, :impact, :score, :likelihood, :_destroy])
    end

    def get_my_risks
      my_risks = Risk.where(user_id: current_user, organization_id: get_current_organisation, status: get_status_filter) 
      my_risks
    end

    def get_topics
      topics = Topic.where(organisation_id: get_current_organisation, status: 1).order('score is null ASC, score DESC')
    end

    def publishing?
      params[:commit] == "Publish"
    end
end
