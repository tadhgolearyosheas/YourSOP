class DocumentsController < ApplicationController
  require 'htmlentities'    # decode encoded HTML tags from diff output

  @@STATUS_DRAFT = 0    # document status filter values for list in index view
  @@STATUS_FOR_REVIEW = 1
  @@STATUS_FOR_APPROVAL = 2
  @@STATUS_APPROVED = 3
  @@STATUS_TRAINING = 4

  before_action :check_current_organisation

  def index
    @documents = get_filtered_documents # view draft documents by current user default
    @my_documents = get_signed_documents
    @current_user = current_user
  end

  def show
    setup_show
  end

  def new
    #everyone should be able to create docs
    #if is_basic(OrganisationUser.where(organisation: get_current_organisation, user: current_user)[0].user_type)
    #  redirect_to :documents, notice: 'Basic user accounts cannot create documents.'
    #end

    @document = Document.new
    @document.document_revisions.build
    setup_new
  end

  def create
    @document = Document.new(document_params)
    @document.organisation = get_current_organisation
    @document.status = @@STATUS_DRAFT

    @document.major_version = "0"
    @document.minor_version = "1"
    @document.do_update = false
    @document.change_control = "Initial creation."
    
    if draft?
      @document.status = 0
    else
      @document.status = 1
    end

    if params[:reviews] != nil
      new_reviewer_ids = params[:reviews]
      new_reviewer_ids.each do |blah, action|
        next if blah.blank?
        blah2 = Review.new
        blah2.user_id = blah.to_i
        blah2.status = 0
        blah2.major_version = @document.major_version
        blah2.minor_version = @document.minor_version
        @document.reviews << blah2
      end
    end

    if params[:approvals] != nil
      new_approver_ids = params[:approvals]
      new_approver_ids.each do |blah, action|
        next if blah.blank?
        blah2 = Approval.new
        blah2.user_id = blah.to_i
        blah2.status = 0
        blah2.major_version = @document.major_version
        blah2.minor_version = @document.minor_version
        @document.approvals << blah2
      end
    end

    if params[:trainees] != nil
      new_traineer_ids = params[:trainees]
      new_traineer_ids.each do |blah, action|
        next if blah.blank?
        blah2 = Trainee.new
        blah2.user_id = blah.to_i
        blah2.status = 0
        blah2.major_version = @document.major_version
        blah2.minor_version = @document.minor_version
        @document.trainees << blah2
      end
    end

    saved = false
    if draft? 
      saved = @document.save!(:validate => false)
    else
      saved = @document.save
      # send mail
      if saved
        send_initial_mail
      end
    end

    if saved
      # continue, create relations
    else
      setup_new
      render action: 'new', alert: 'Document could not be created'
      return
    end    

    if params[:document][:assigned_to_all] != nil
      if params[:readers] != nil
        new_reader_ids = params[:readers]
        new_reader_ids.each do |id, action|
          next if id.blank?
          r = Reader.new
          r.user_id = id.to_i
          r.document = @document
          r.save
        end
      end
    end
  	
    if draft?
      msg = 'Document was successfully saved.'
    else
      msg = 'Document was successfully created.'
    end

    redirect_to action: 'index', notice: msg
  end

  def edit
    @document = Document.find(params[:id])
    if @document.user != current_user
      flash[:warning] = 'You can only edit documents created by you.'
      redirect_to action: 'index'
    end
    if @document.status != 0
      flash[:warning] = 'You can only edit documents that are in the Draft state.'
      redirect_to action: 'index'
    end
    setup_edit
  end

  def revise
     @document = Document.find(params[:id])
    if @document.user != current_user
      flash[:warning] = 'You can only revise documents created by you.'
      redirect_to action: 'index'
    end

    if @document.status != @@STATUS_APPROVED
      flash[:warning] = 'You can only revise documents that are in the Effective state.'
      redirect_to action: 'index'
    end
    setup_edit
  end

  def update
    @document = Document.find(params[:id])

    if @document.do_update == true and draft? == false
      @document_revision = DocumentRevision.new(major_version: @document.major_version, minor_version: @document.minor_version, content: @document.content,
                                                change_control: @document.change_control, document_id: @document.id)
      # minor verison + 1
      minor_version = (@document.minor_version.to_i + 1).to_s
      @document.update(minor_version: minor_version, do_update: false)
      @document_revision.save
    end

    reviews =  @document.reviews.find_by_document_id_and_major_version_and_minor_version(@document.id, @document.major_version, @document.minor_version)
    if reviews.present?
      reviews.destroy
    end

    approvals = @document.approvals.find_by_document_id_and_major_version_and_minor_version(@document.id, @document.major_version, @document.minor_version)
    if approvals.present?
      approvals.destroy
    end
    
    users = @document.trainees.find_by_document_id_and_major_version_and_minor_version(@document.id, @document.major_version, @document.minor_version)
    if users.present?
      users.destroy
    end

    @document.reload

    if params[:reviews] != nil
      new_reviewer_ids = params[:reviews]
      new_reviewer_ids.each do |blah, action|
        next if blah.blank?
        blah2 = Review.new
        blah2.user_id = blah.to_i
        blah2.status = 0
        blah2.major_version = @document.major_version
        blah2.minor_version = @document.minor_version
        @document.reviews << blah2
      end
    end

    if params[:approvals] != nil
      new_approver_ids = params[:approvals]
      new_approver_ids.each do |blah, action|
        next if blah.blank?
        blah2 = Approval.new
        blah2.user_id = blah.to_i
        blah2.status = 0
        blah2.major_version = @document.major_version
        blah2.minor_version = @document.minor_version
        @document.approvals << blah2
      end
    end

    if params[:trainees] != nil
      new_traineer_ids = params[:trainees]
      new_traineer_ids.each do |blah, action|
        next if blah.blank?
        blah2 = Trainee.new
        blah2.user_id = blah.to_i
        blah2.status = 0
        blah2.major_version = @document.major_version
        blah2.minor_version = @document.minor_version
        @document.trainees << blah2
      end
    end

    saved = false
    if draft? 
      saved = @document.update_columns(document_params)
    else
      saved = @document.update(document_params.merge(:status => 1))
      if saved
        send_initial_mail
      end
    end

    if saved
      flash[:success] = 'Document was successfully updated.'
      redirect_to action: 'show'
    else
      setup_edit
      flash[:danger] = 'Document could not be updated.'
      render action: 'edit'
    end

  end

  def compare
    @document = Document.find(params[:id])
    @html_diff = ''

    if params[:revision1] == params[:revision2]
      flash[:danger] = 'You cannot compare a document revision to itself.'
      redirect_to document_path @document.id
      return
    end

    # check for revision id == 0 (current revision)
    # older revision has lower DocumentRevision id
    if params[:revision1] == '0'
      @older_revision = DocumentRevision.find(params[:revision2])
      @newer_revision = @document
    elsif params[:revision2] == '0'
      @older_revision = DocumentRevision.find(params[:revision1])
      @newer_revision = @document
    else
      if params[:revision1].to_i < params[:revision2].to_i    # revision 1 id is smaller, it is an older revision
        @older_revision = DocumentRevision.find(params[:revision1])
        @newer_revision = DocumentRevision.find(params[:revision2])
      else
        @older_revision = DocumentRevision.find(params[:revision2])
        @newer_revision = DocumentRevision.find(params[:revision1])
      end
    end

    @html_diff = get_html_diff @older_revision, @newer_revision
  end

  def revision
    @document = Document.find(params[:id])
    @document_revisions = DocumentRevision.where(document_id: @document.id).order(id: :desc)
    @revision = DocumentRevision.find_by_document_id_and_major_version_and_minor_version params[:id], params[:major], params[:minor]
    if @revision == nil
      setup_show
      flash[:warning] = "#{@document.title} revision #{params[:major]}.#{params[:minor]} was not found."
      redirect_to document_path(params[:id])
    end
  end


  def revert_to_draft
    if (params[:id] == nil) 
      return
    end

    document = Document.find(params[:id].to_i)
    if document.user_id != current_user.id or document.status != @@STATUS_APPROVED
      flash[:danger] = 'You cannot perform this operation.'
      redirect_to documents_path
    end
    document_revision = DocumentRevision.new(major_version: document.major_version, minor_version: document.minor_version, content: document.content,
                                                change_control: document.change_control, document_id: document.id)
    minor_version = (document.minor_version.to_i + 1).to_s
    document.update(minor_version: minor_version, status: @@STATUS_DRAFT, do_update: false)
    document_revision.save

    flash[:success] = 'You have reverted this document to draft.'
    render :js => "window.location = '/documents'"
  end

  # handle 'Approve/Decline/Mark as reviewed' button click in document show view
  def save_role_response
    if params[:decline] == nil    # require a digital signature to approve/mark as reviewed
      # password is filtered in params log by Devise gem (not visible in params array)
      if params[:email] != current_user.email || !current_user.valid_password?(params[:password])   # if wrong email or password
        if params[:review] != nil
          document = Review.find(params[:relation_id].to_i).document
          setup_show
          flash[:danger] = 'Incorrect email or password.'
          redirect_to document_path(document.id)
          return
        else
          document = Approval.find(params[:relation_id].to_i).document
          setup_show
          flash[:danger] = 'Incorrect email or password.'
          redirect_to document_path(document.id)
          return
        end
      end
    end

    success = ''
    if params[:approve] != nil
      a = Approval.find params[:relation_id].to_i
      a.status = 1
      a.save
      success = 'You have approved this document.'

      # if all approvers have approved the document, make it effective
      approvals = Approval.where(document: a.document, major_version: a.document.major_version, minor_version: a.minor_version).where.not(status: 1)   # approvals where status != approved
      if approvals.empty?
        a.document.update(status: 3, do_update: true)    # document is now effective, and ready for revision
        
        # update major version, reset minor version
        @document = a.document
        @document_revision = DocumentRevision.new(major_version: @document.major_version, minor_version: @document.minor_version, content: @document.content,
                                                  change_control: @document.change_control, document_id: @document.id)
        @document_revision.save

        @document.major_version = (@document.major_version.to_i + 1).to_s
        @document.minor_version = "0"
        @document.save
        email_notify
        Notifier.doc_status(User.find(@document.user_id).email,@document.title,'Approved').deliver_later

      end
    elsif params[:decline] != nil
      a = Approval.find params[:relation_id].to_i
      document = a.document
      email = a.user.email
      a.status = 2
      a.save
      Notifier.doc_status(User.find(document.user_id).email,document.title,"Declined by #{email}").deliver_later
      #if one reject, just mark document to draft, 
      doc = Document.find(a.document_id)
      doc.update(status: 0, do_update: true)
      
      #and cancel other approvals
      approvals = Approval.where(document: a.document, status: 0, major_version: a.document.major_version, minor_version: a.minor_version)
      approvals.each do |a|
        a.update(status: 3) # skip
      end
      
      success = 'You have declined this document.'
    elsif params[:review] != nil
      r = Review.find params[:relation_id].to_i
      r.status = 1
      r.save
      
      # if all reviewd mark document as in approval
      count = Review.where(document_id: r.document_id, status: 0, major_version: r.document.major_version, minor_version: r.minor_version).count()
      if count == 0
        doc = Document.find(r.document_id)
        doc.update(status: 2)
        @document = r.document
        email_notify
      end
      
      success = 'You have marked this document as reviewed.'
      

    elsif params[:train] != nil
      t = Trainee.find params[:relation_id].to_i
      t.status = 1
      t.save

      success = "You have signed off this document."

    end

    setup_show
    
    if success.include? "declined"
      flash[:danger] = success
    else
      flash[:success] = success
    end

    render :show
    end
  
  def destroy
    @document = Document.find(params[:id])
    if @document.status != @@STATUS_DRAFT
      flash[:danger] = 'You can only delete draft.'
      return
    end

    if @document.destroy
      flash[:success] = 'Document was successfully deleted.'
    else
      flash[:danger] = 'Document was not deleted.'
    end
    redirect_to documents_path
  end

  private

  def setup_show
    @document = Document.find(params[:id])
    @user = current_user
    @document_revisions = DocumentRevision.where(document_id: @document.id).order(id: :desc)

    @reader_users = []

    commontator_thread_show(@document)

    readers = Reader.where(document: @document)
    readers.each do |r|
      @reader_users << {reader: r, user: r.user}
    end

    max_major_version = Review.where(document_id: @document.id).maximum(:major_version)
    max_minor_version = Review.where(document_id: @document.id, major_version: max_major_version).maximum(:minor_version)

    @review_users = []

    reviews = Review.where(document_id: @document.id, major_version: max_major_version, minor_version: max_minor_version)
    reviews.each do |r|
      @review_users << {review: r, user: r.user}
    end

    @approval_users = []

    approvals = Approval.where(document_id: @document.id, major_version: max_major_version, minor_version: max_minor_version)
    approvals.each do |a|
      @approval_users << {approval: a, user: a.user}
    end

    @trainee_users = []

    trainees = Trainee.where(document_id: @document.id, major_version: max_major_version, minor_version: max_minor_version)
    trainees.each do |a|
      @trainee_users << {trainee: a, user: a.user}
    end

    @review = Review.find_by_user_id_and_document_id_and_major_version_and_minor_version current_user.id, @document.id, max_major_version, max_minor_version
    @approval = Approval.find_by_user_id_and_document_id_and_major_version_and_minor_version current_user.id, @document.id, max_major_version, max_minor_version
    @trainee = Trainee.find_by_user_id_and_document_id_and_major_version_and_minor_version current_user.id, @document.id, max_major_version, max_minor_version
    if @document.status == @@STATUS_FOR_REVIEW && @review != nil
      @is_reviewer = true
      @relation_id = @review.id
    elsif @document.status == @@STATUS_FOR_APPROVAL && @approval != nil
      @is_approver = true
      @relation_id = @approval.id
    elsif @trainee != nil
      @is_traineer = true
      @relation_id = @trainee.id
    end

  end

  def setup_new
    # user can assign themself to roles. to disable this, add: .where.not(user_id: current_user.id)
    organisation_users = OrganisationUser.where(organisation_id: get_current_organisation.id, accepted: true)
    @users_to_select = []
    organisation_users.each do |ou|
      @users_to_select << ou.user
    end

    @current_user_id = current_user.id

    @topics = Topic.where(organisation_id: get_current_organisation.id, status: 1)


  end

  def setup_edit
    @edit = true

    current_org_id = get_current_organisation.id
    organisation_users = OrganisationUser.where(organisation_id: current_org_id, accepted: true)
    @users_to_select = []
    @existing_approver_ids = []
    @existing_reader_ids = []
    @existing_reviewer_ids = []
    @existing_traineer_ids = []

    organisation_users.each do |ou|
      user = ou.user
      @users_to_select << user
      if Approval.exists?(document: @document, user: user)
        @existing_approver_ids << user.id
      end
      if Reader.exists?(document: @document, user: user)
        @existing_reader_ids << user.id
      end
      if Review.exists?(document: @document, user: user)
        @existing_reviewer_ids << user.id
      end
      if Trainee.exists?(document: @document, user: user)
        @existing_traineer_ids << user.id
      end
    end

    @current_user_id = current_user.id

    @topics = Topic.where(organisation_id: get_current_organisation.id, status: 1)
  end

  def document_params
    params.require(:document).permit(:content, :doc, :topic_id, :title, :user_id, :review_date, :change_control)
  end

  def send_initial_mail
    @document.reviews.where(major_version: @document.major_version, minor_version: @document.minor_version, status: 0).each do |blah2|
      Notifier.assign_role(User.find(blah2.user_id).email,@document.title,User.find(@document.user_id).email,'Reviewer').deliver_later
      Notifier.do_action(User.find(blah2.user_id).email,@document.title,User.find(@document.user_id).email,'Review').deliver_later 
    end
    
    @document.approvals.where(major_version: @document.major_version, minor_version: @document.minor_version, status: 0).each do |blah2|
      Notifier.assign_role(User.find(blah2.user_id).email,@document.title,User.find(@document.user_id).email,'Approver').deliver_later
    end

    @document.trainees.where(major_version: @document.major_version, minor_version: @document.minor_version, status: 0).each do |blah2|
      Notifier.assign_role(User.find(blah2.user_id).email,@document.title,User.find(@document.user_id).email,'User').deliver_later
    end
  end

  def email_notify
    max_major_version = @document.reviews.maximum(:major_version)
    max_minor_version = @document.reviews.where(document_id: @document.id, major_version: max_major_version).maximum(:minor_version)

    if params[:review] != nil
      @document.approvals.where(major_version: max_major_version, minor_version: max_minor_version).each do |pr|
        Notifier.do_action(pr.user.email,@document.title,User.find(@document.user_id).email,'Approval').deliver_later
      end
    end

    if params[:approve] != nil
      @document.trainees.where(major_version: max_major_version, minor_version: max_minor_version).each do |rr|
        Notifier.do_action(rr.user.email,@document.title,User.find(@document.user_id).email,'Sign off').deliver_later
      end
    end

  end

  # check if user has an active organisation
  def check_current_organisation
    if get_current_organisation == nil
      flash[:warning] = "You must select an organisation before viewing documents."
      redirect_to root_path
    end
  end

  def status_change_to_int status
    if status == "Draft" || status == "Revert to draft"
      0
    elsif status == "Send for review" || status == "For review"
      1
    elsif status == "Send for approval" || status == "For approval"
      2
    elsif status == "Effective"
      3
    elsif status == "Send for Users" || status == "For compliant"
      4
    else # unknown
      -1
    end
  end

  #def set_status_filter filter
  #  session[:status_filter] = filter
  #end

  #def get_status_filter
  #  session[:status_filter].to_i
  #end

  # get documents for list in index view
  def get_filtered_documents
    # check status filters
#      if get_status_filter == @@STATUS_DRAFT # draft, you have been assigned as a reviewer or approver
#        get_draft_documents_for_review | get_draft_documents_for_approval
#      elsif get_status_filter == @@STATUS_FOR_REVIEW
#        get_documents_for_review
#      elsif get_status_filter == @@STATUS_FOR_APPROVAL
#        get_documents_for_approval
#      elsif get_status_filter == @@STATUS_APPROVED
#        get_approved_documents
#      end
  	  sql = "organisation_id = ? 
            and
            (
            (user_id = ?) 
            or (status = 1 and exists(select 0 from reviews where document_id = documents.id and status = 0 and user_id = ?))
            or (status = 2 and exists(select 0 from approvals where document_id = documents.id and status = 0 and user_id = ?))
            or status = 3
             )"
      Document.where(sql, get_current_organisation.id, current_user.id, current_user.id, current_user.id).order(status: :asc, created_at: :desc)
  end

  def get_signed_documents
    Document.joins(:trainees).where("documents.organisation_id = ? and documents.status = ? and trainees.user_id = ?", get_current_organisation.id, @@STATUS_APPROVED, current_user.id)
  end

  def get_documents_for_review
    documents_for_review = []
    reviews = Review.where user_id: current_user.id
    reviews.each do |r|
      if r.document.organisation == get_current_organisation && r.document.status == @@STATUS_FOR_REVIEW
        documents_for_review << r.document
      end
    end
    documents_for_review
  end

  def get_documents_for_approval
    documents_for_approval = []
    approvals = Approval.where user_id: current_user.id
    approvals.each do |a|
      if a.document.organisation == get_current_organisation && a.document.status == @@STATUS_FOR_APPROVAL
        documents_for_approval << a.document
      end
    end
    documents_for_approval
  end

  def get_draft_documents_for_review
    documents_for_review = []
    reviews = Review.where user_id: current_user.id
    reviews.each do |r|
      if r.document.organisation == get_current_organisation && r.document.status == @@STATUS_DRAFT
        documents_for_review << r.document
      end
    end
    documents_for_review
  end

  def get_draft_documents_for_approval
    documents_for_approval = []
    approvals = Approval.where user_id: current_user.id
    approvals.each do |a|
      if a.document.organisation == get_current_organisation && a.document.status == @@STATUS_DRAFT
        documents_for_approval << a.document
      end
    end
    documents_for_approval
  end

  def get_approved_documents
    documents_approved = []
    approvals = Approval.where user_id: current_user.id
    approvals.each do |a|
      if a.document.organisation == get_current_organisation && a.document.status == @@STATUS_APPROVED
        documents_approved << a.document
      end
    end
    documents_approved
  end

  def get_training_document
    documents_training = []
    trainees = Trainee.where user_id: current_user.id
    trainees.each do |t|
      if t.document.organisation == get_current_organisation && t.document.status == @@STATUS_TRAINING
        documents_training << t.document
      end
    end
    documents_training
  end

  def get_your_documents status
    Document.where(organisation_id: get_current_organisation.id, status: status, user_id: current_user.id)
  end

  def get_reader_documents status
    documents = Document.where(organisation: get_current_organisation, status: status)
    reader_documents = []
    documents.each do |d|
      if d.assigned_to_all || Reader.where(user: User.first, document: Document.first).count > 0
        reader_documents << d
      end
    end
    reader_documents
  end

  # older revision on the left => lines that are present in newer_rev but not older_rev are displayed as "added" lines
  # Diffy html diff encodes (escapes) HTML tags, use HTMLEntities gem to encode them back into HTML tags
  def get_html_diff older_rev, newer_rev
    diff_output = Diffy::Diff.new(older_rev.content, newer_rev.content, :allow_empty_diff => false).to_s(:html_simple)
    HTMLEntities.new.decode(diff_output)
  end
  
  def draft?
    params[:commit] == "Save as Draft"
  end
end
