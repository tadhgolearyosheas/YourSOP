class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :check_current_organisation

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.where(organisation_id: current_organisation.id)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new

    setup_new
  end

  # GET /topics/1/edit
  def edit

    setup_edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.organisation_id = current_organisation.id

    if params[:services] != nil
      service_ids = params[:services]
      service_ids.each do |blah, action|
        next if blah.blank?
        blah2 = TopicService.new
        blah2.service_id = blah.to_i
        @topic.topic_services << blah2
      end
    end

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update

    topic_services =  @topic.topic_services.find_by_topic_id(@topic.id)
      if topic_services.present?
        topic_services.destroy
      end

    if params[:services] != nil
      service_ids = params[:services]
      service_ids.each do |blah, action|
        next if blah.blank?
        blah2 = TopicService.new
        blah2.service_id = blah.to_i
        @topic.topic_services << blah2
      end
    end

    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def setup_new
      @existing_service_ids = []

      @services = Service.all
    end

    def setup_edit
      @existing_service_ids = []
      @services = Service.all

      @topic.topic_services.each do |s|
        @existing_service_ids << s.service_id
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :description, :status)
    end
end
