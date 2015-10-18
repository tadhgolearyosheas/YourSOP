class AuditsController < ApplicationController

  before_action :check_current_organisation 
  #before_action :check_current_user_is_quality,  except: :index

  @@audits_practices_result = Hash[ "Green", 1, "Amber", 2, "Red", 3 ]

  @@STATUS_DRAFT = 0    
  @@STATUS_FOR_REVIEW = 1
  @@STATUS_FOR_APPROVAL = 2
  @@STATUS_APPROVED = 3
  @@STATUS_AUDITING = 4
  @@STATUS_FINISHED = 5

  # GET /audits
  # GET /audits.json
  def index
    if get_status_filter == nil
      set_status_filter @@STATUS_DRAFT
    end

    @audits = get_audits

    @draft_count = get_audits_count @@STATUS_DRAFT
    @review_count = get_audits_count @@STATUS_FOR_REVIEW
    @approval_count = get_audits_count @@STATUS_FOR_APPROVAL
    @approved_count = get_audits_count @@STATUS_APPROVED
    @auditing_count = get_audits_count @@STATUS_AUDITING
    @finished_count = get_audits_count @@STATUS_FINISHED

    @status = get_status_filter

  end

  def list_audits
    @audits = get_audits
    render 'list.js.erb'
  end

  def show
    @audit = Audit.find(params[:id])
    
    setup_show
  end

  def new
    id = params[:id]
     #check if active audit exist
    if check_if_active_audit_exist id
      redirect_to risks_path, notice: 'There is already an active audit, a topic can only one active audit.'
    end

    if !check_if_topic_has_risk_assessment id
      redirect_to risks_path, notice: 'Please assess risks of this topic first.'
    end

    @topic = Topic.find(id)
    @topic_id = @topic.id
    @risk = Risk.where(topic_id: @topic.id, status: 1).first
    @audit = Audit.where(topic_id: @topic.id, status: -1).first

   setup_new
  end

  def edit
    @audit = Audit.find(params[:id])
    @topic = Topic.find(@audit.topic_id)
    @topic_id = @topic.id
    @risk = Risk.where(topic_id: @topic.id, status: 1).first
    
    setup_edit
  end

  def create
    @audit = Audit.new(audit_params)
    @topic = @audit.topic
    @topic_id = @audit.topic_id
    @audit.user_id = current_user.id
    @risk = Risk.where(topic_id: @topic.id, status: 1).first
    risk = Risk.find_by_topic_id_and_status(@audit.topic_id, 1);
    @audit.risk_id = risk.id
    @topic = Topic.find(@audit.topic_id)
    
    
    
    if params[:reviews] != nil
      new_reviewer_ids = params[:reviews]
      new_reviewer_ids.each do |blah, action|
        next if blah.blank?
        blah2 = AuditReview.new
        blah2.user_id = blah.to_i
        blah2.status = 0
        @audit.audit_reviews << blah2
      end
    end

    if params[:approvals] != nil
      new_approver_ids = params[:approvals]
      new_approver_ids.each do |blah, action|
        next if blah.blank?
        blah2 = AuditApproval.new
        blah2.user_id = blah.to_i
        blah2.audit = @audit
        blah2.status = 0
        @audit.audit_approvals << blah2

        
      end
    end

    saved = false
    if auditing?
      @audit.status = @@STATUS_FOR_REVIEW
      saved = @audit.save
      if saved
        send_initial_mail
      end
    else
      @audit.status = @@STATUS_DRAFT
      saved = @audit.save!(:validate => false)
    end

    if saved
      update_audit_doc_version @audit.id
      redirect_to @audit
    else
      setup_new
      render action: 'new'
      return
    end
  end

  def update
    @audit = Audit.find(params[:id])
    @topic = Topic.find(@audit.topic_id)
    if draft? or auditing?
      reviews =  @audit.audit_reviews.find_by_audit_id(@audit.id)
      if reviews.present?
        reviews.destroy
      end

      approvals = @audit.audit_approvals.find_by_audit_id(@audit.id)
      if approvals.present?
        approvals.destroy
      end
      @audit.reload

      if params[:reviews] != nil
        new_reviewer_ids = params[:reviews]
        new_reviewer_ids.each do |blah, action|
          next if blah.blank?
          blah2 = AuditReview.new
          blah2.user_id = blah.to_i
          blah2.status = 0
          @audit.audit_reviews << blah2
        end
      end

      if params[:approvals] != nil
        new_approver_ids = params[:approvals]
        new_approver_ids.each do |blah, action|
          next if blah.blank?
          blah2 = AuditApproval.new
          blah2.user_id = blah.to_i
          blah2.audit = @audit
          blah2.status = 0
          @audit.audit_approvals << blah2
        end
      end

    end

    saved = false
    if draft? or temp_save?
      @audit.attributes = audit_params.merge(:end_date => nil)
      saved = @audit.save!(:validate => false)
    elsif auditing?
      saved = @audit.update(audit_params.merge(:status => @@STATUS_FOR_REVIEW))
      if saved
        send_initial_mail
      end
    elsif publish?
      @audit.attributes = audit_params.merge(:status => @@STATUS_FINISHED)
      saved = @audit.save!(:validate => false)
      if saved
        @topic = Topic.find(@audit.topic_id)
        @topic.update(last_audit_date: @audit.end_date)
      end
    end

    if saved
      update_audit_doc_version @audit.id
      redirect_to audits_path
    else
      if draft? or auditing?
        @topic = Topic.find(@audit.topic_id)
        @topic_id = @topic.id
        @risk = Risk.where(topic_id: @topic.id, status: 1).first
        setup_edit
        render action: 'edit', :id => @audit.id, alert: 'Audit ould not be updated.'
      elsif publish? or temp_save
        @audit.audits_practices.each do |p|
           p.audits_practices_actions.build
         end
        @topic = Topic.find(@audit.topic_id)        
        @risk = Risk.where(topic_id: @topic.id, status: 1).first        
        @audits_practices_result = @@audits_practices_result       
        @topic_id = @topic.id       
        @start_date = @audit.start_date   
        setup_result
        render action: 'result', :id => @audit.id, alert: 'Audit ould not be saved.'
      end
      
    end

  end

  def result
     @audit = Audit.find(params[:id])
     @audit.audits_practices.each do |p|
       p.audits_practices_actions.build
     end
    @topic = Topic.find(@audit.topic_id)		    
    @risk = Risk.where(topic_id: @topic.id, status: 1).first		    
    @audits_practices_result = @@audits_practices_result		   
    @topic_id = @topic.id		    
    @start_date = @audit.start_date		   
    setup_result
  end

  def setup_result
    @users_to_select = []
    users = OrganisationUser.where(organisation_id: get_current_organisation.id, accepted: true)
    users.each do |ou|
      if ou.user == nil
        raise ou.user
      end
      @users_to_select << ou.user
    end
  end


  def handle_audit_status
    if params[:status] != nil # view audits with different status
      set_status_filter risk_status_to_int params[:status]
      @new_audits = get_audits
      respond_to do |format|
        format.js
      end
    end
  end

  def start_audit
    if (params[:id] == nil) 
      return
    end

    audit = Audit.find(params[:id].to_i)
    if audit.status != @@STATUS_APPROVED or !is_quality(OrganisationUser.where(user: current_user, organisation: @current_organisation)[0].user_type)
      flash[:danger] = 'You cannot perform this operation.'
      render :js => "window.location = '/audits'"
    end
    audit.update(status: @@STATUS_AUDITING, start_date: Time.now);

    flash[:success] = 'You have maked this audit started.'
    render :js => "window.location = '/audits'"

  end

  #def restart_audit
  #    @audit = Audit.find(params[:id])
  #    if @audit.user != current_user
  #      flash[:warning] = 'You can only revise documents created by you.'
  #      redirect_to action: 'index'
  #    end

  #    if @audit.status != @@STATUS_FINISHED
  #     flash[:warning] = 'You can only revise documents that are in the Effective state.'
  #      redirect_to action: 'index'
  #    end
  #    redirect_to edit_audit_path
  #end
  
  def save_audit_response
    	if params[:decline] == nil    # require a digital signature to approve/mark as reviewed
      # password is filtered in params log by Devise gem (not visible in params array)
      if params[:email] != current_user.email || !current_user.valid_password?(params[:password])   # if wrong email or password
        if params[:review] != nil
          @audit = AuditReview.find(params[:relation_id].to_i).audit
          setup_show
          flash[:danger] = 'Incorrect email or password.'
          redirect_to audit_path(@audit.id)
          return
        else
          @audit = AuditApproval.find(params[:relation_id].to_i).audit
          setup_show
          flash[:danger] = 'Incorrect email or password.'
          redirect_to audit_path(@audit.id)
          return
        end
      end
    end

    success = ''
    if params[:approve] != nil
      a = AuditApproval.find params[:relation_id].to_i
      a.status = 1
      a.save
      success = 'You have approved this audit.'

      # if all approvers have approved the audit, make it effective
      approvals = AuditApproval.where(audit: a.audit).where.not(status: 1)   # approvals where status != approved
      @audit = a.audit
      @topic = Topic.find(@audit.topic_id)
      if approvals.empty?
        @audit.update(status: @@STATUS_APPROVED)    # audit is now approved
        Notifier.audit_status(User.find(@audit.user_id).email, @topic.name, 'Approved').deliver_later

        # TODO: Send email to creator of audit to notify of approval
        #Notifier.doc_status(User.find(document.user_id).email,document.title,'Approved').deliver_now

      end
    elsif params[:decline] != nil
      a = AuditApproval.find params[:relation_id].to_i
      @audit = a.audit
      @topic = Topic.find(@audit.topic_id)
      a.status = 2
      a.save
      
      #if one reject, just mark audit to draft, 
      @audit = Audit.find(a.audit_id)
      @audit.update(status: @@STATUS_DRAFT)
      Notifier.audit_status(User.find(@audit.user_id).email, @topic.name, "Decline by #{a.user.email}").deliver_later
      
      #and cancel other approvals
      approvals = AuditApproval.where(audit: a.audit, status: 0)
      approvals.each do |a|
        a.update(status: 3) # skip
      end
      
      # TODO: cancel all other approval actions
      
      success = 'You have declined this audit.'
    elsif params[:review] != nil
      r = AuditReview.find params[:relation_id].to_i
      r.status = 1
      r.save
      
      @audit = Audit.find(r.audit_id)
      # if all reviewd mark audit as in approval
      count = AuditReview.where(audit_id: r.audit_id, status: 0).count()
      if count == 0
        @audit.update(status: @@STATUS_FOR_APPROVAL)
        @topic = Topic.find(@audit.topic_id)
        email_notify
      end
      
      success = 'You have marked this audit as reviewed.'
    end
    
    setup_show
    flash[:success] = success
    render :show
    
  end



  def risk_status_to_int status
        if status.start_with? == "Draft"
            0
        elsif status.start_with? "For review"
            1
        elsif status.start_with? "For approval"
            2
        elsif status.start_with? "Approved"
            3
        elsif status.start_with? "Auditing"
            4
        elsif status.start_with? "Finished"
            5
        else
            0
        end
  end

  private
    def setup_new
      @existing_reviewer_ids = []
      @existing_approver_ids = []

      if @audit == nil
        @audit = Audit.new(:topic_id => @topic.id, :start_date => Time.now, :status => 0)
        #check if there is andit with current topic in history
        last_audit = Audit.where(topic_id: @topic.id, status: @@STATUS_FINISHED).order("created_at desc").first
        if last_audit.present?
          last_audit.audits_practices.each do |p|
            ap = AuditsPractice.new
            ap.observation = p.observation
            p.documents.each do |d|
              ap.documents << d
            end
            @audit.audits_practices << ap
          end

          last_audit.audit_reviews.each do |r|
            @existing_reviewer_ids << r.user_id
          end
          
          last_audit.audit_approvals.each do |a|
            @existing_approver_ids << a.user_id
          end
        end
      elsif !@audit.audits_practices.present?
        @audit.audits_practices.build
      end
    end

    def setup_edit
      @existing_reviewer_ids = []
      @existing_approver_ids = []
      @audit.audit_reviews.each do |r|
        @existing_reviewer_ids << r.user_id
      end
      
      @audit.audit_approvals.each do |a|
        @existing_approver_ids << a.user_id
      end
    end

    def get_audits
      audits = Audit.joins(:topic).where("topics.organisation_id = ? and audits.status = ? ", get_current_organisation, get_status_filter) 
      audits
    end

    def get_audits_count status
      count = Audit.joins(:topic).where("topics.organisation_id = ? and audits.status = ? ", get_current_organisation, status).count
      if count == 0
        return ""
      else
        return "(" + count.to_s + ")"
      end
    end

    def set_status_filter filter
      session[:audits_filter] = filter
    end

    def get_status_filter
      session[:audits_filter].to_i
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audit_params
      params.require(:audit).permit(:id, :topic_id, :status, :start_date, :end_date, :result, :user_ids => [], audits_practices_attributes: [:id, :observation, :result, :evidence, :attachment, { :document_ids => [] }, :_destroy, audits_practices_actions_attributes: [:id, :action, :user_id, :status, :_destroy] ])
    end

    def check_if_active_audit_exist topic_id
       count = Audit.where("audits.topic_id = ? and audits.status != 5 and audits.status > 0", topic_id).count
       return count > 0
    end

    def check_if_topic_has_risk_assessment topic_id
      count = Risk.where("risks.topic_id = ? and risks.status = 1", topic_id).count
      return count > 0
    end
    
    def setup_show
        @topic = Topic.find(@audit.topic_id)
        @risk = Risk.where(topic_id: @topic.id, status: 1).first
    
      	@review = AuditReview.find_by_user_id_and_audit_id current_user.id, @audit.id
        @approval = AuditApproval.find_by_user_id_and_audit_id current_user.id, @audit.id
        if @audit.status == @@STATUS_FOR_REVIEW && @review != nil
          @is_reviewer = true
          @relation_id = @review.id
        end
        if @audit.status == @@STATUS_FOR_APPROVAL && @approval != nil
          @is_approver = true
          @relation_id = @approval.id
        end
        
        @review_users = []
        reviews = AuditReview.where(audit_id: @audit.id)
        reviews.each do |r|
          @review_users << {review: r, user: r.user}
        end
    
        @approval_users = []
        approvals = AuditApproval.where(audit_id: @audit.id)
        approvals.each do |a|
          @approval_users << {approval: a, user: a.user}
        end
    end



    def auditing?
      params[:commit] == "Send For Review"
    end

    def draft?
      params[:commit] == "Save as Draft"
    end

    def publish?
      params[:commit] == "Publish Audit"
    end

    def temp_save?
      params[:commit] == "Temparory Save"
    end

    def update_audit_doc_version audit_id
      audits_practices_doc = AuditsPracticesDocument.joins(:audits_practice).where("audits_practices.audit_id = ?", audit_id)
      audits_practices_doc.each do |d|
        doc = Document.find(d.document_id)
        d.update(major_version: doc.major_version)
      end
    end

    def send_initial_mail
      @audit.audit_reviews.where(status: 0).each do |blah2|
        Notifier.assign_audit_role(blah2.user.email,@topic.name,User.find(@audit.user_id).email,'Reviewer').deliver_later
        Notifier.do_audit_action(blah2.user.email,@topic.name,User.find(@audit.user_id).email,'Review').deliver_later
      end
      
      @audit.audit_approvals.where(status: 0).each do |blah2|
        Notifier.assign_audit_role(blah2.user.email,@topic.name,User.find(@audit.user_id).email,'Approver').deliver_later
      end
    end

    def email_notify
      @audit.audit_approvals.where(status: 0).each do |blah2|
        Notifier.do_audit_action(blah2.user.email,@topic.name,User.find(@audit.user_id).email,'Approval').deliver_later
      end
    end
end