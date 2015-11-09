class OrganisationsController < ApplicationController
  # autocomplete :user, :email
  respond_to :json

  def index
    prepare_index

    if @organisations.empty?
      @organisation = Organisation.new
    end
  end

  def new
    @organisation = Organisation.new
    @current_user_id = current_user.id
  end

  def create
    @organisation = Organisation.new(organisation_params)

    organisation_user = OrganisationUser.new(organisation: @organisation, user: current_user)   # current user is organisation creator
    organisation_user.accepted = true
    organisation_user.user_type = 2
    organisation_user.inviter_id = current_user.id

    if @organisation.save && organisation_user.save
      set_current_organisation_id @organisation.id
      redirect_to action: 'index', notice: 'Organisation was successfully created.'
    else
      prepare_index
      render action: 'index', alert: 'Organisation could not be created'
    end
  end

  def invite
    if ( !@current_user_is_owner and @current_user_is_quality)
      redirect_to :organisations, notice: 'Only owners and quality manager can invite users.'
    end
    @typesOptions = [['Quality', 0], ['Basic', 1], ['Owner', 2]]
    @users = []
    users = User.all
    users.each do |u|
      if OrganisationUser.find_by_user_id_and_organisation_id(u.id, get_current_organisation.id) == nil
        @users << [u.email, u.id]
      end
    end
  end

  def inviteSubmission

    params[:organisation_user][:email].split(";").each do |selected_email|

    if User.where(email: selected_email).first.nil?
      # Users not registered yet
      pending_user = PendingUser.new
      pending_user.email = selected_email
      pending_user.user_type = params[:organisation_user][:typesSelection].to_i
      pending_user.inviter_id = current_user.id
      pending_user.organisation_id = get_current_organisation.id
      pending_user.save

      Notifier.org_invite(selected_email, Organisation.find(pending_user.organisation_id).name, User.find(pending_user.inviter_id).email, params[:organisation_user][:message]).deliver_now

    else
      # Users that have registered
      if selected_email != ''
        invited_user = OrganisationUser.new
        invited_user.user_id = User.where(email: selected_email).first.id
        invited_user.organisation_id = get_current_organisation.id
        invited_user.accepted = false
        invited_user.user_type = params[:organisation_user][:typesSelection].to_i
        invited_user.inviter_id = current_user.id
        invited_user.save

        Notifier.org_invite(selected_email, Organisation.find(invited_user.organisation_id).name, User.find(invited_user.inviter_id).email, params[:organisation_user][:message]).deliver_now
      end
      
    end

    end
    redirect_to :organisations, notice: "Unregistered user has been invited."
  end

  def users
    @organisation_users = []
    @organisation_user_id = get_current_organisation.id
    @organisation_user_type = OrganisationUser.find_by_user_id_and_organisation_id(current_user.id, @organisation_user_id).user_type
    users = User.all
    users.each do |u|
      ou = OrganisationUser.find_by_user_id_and_organisation_id(u.id, get_current_organisation.id)
      if ou != nil
        @organisation_users << {user: u, organisation_user: ou, organisation: ou.organisation}
      end
    end

    @pending_users = []
    pending_users = PendingUser.all
    pending_users.each do |u|
      @pending_users << u
    end

  end

  def save_current_organisation
    set_current_organisation_id params[:organisation_id]
    redirect_to "/"      # call index action
  end

  def accept_organisation_invitation
    ou = OrganisationUser.find_by_user_id_and_organisation_id(current_user.id, params[:organisation_id].to_i)
    ou.accepted = true
    ou.save
    redirect_to :organisations, notice: "Invitation to organisation accepted."      # call index action
  end

  def decline_organisation_invitation
    ou = OrganisationUser.find_by_user_id_and_organisation_id(current_user.id, params[:organisation_id].to_i)
    ou.destroy
    redirect_to :organisations, notice: "Invitation to organisation declined."      # call index action
  end

  def remove_user
    ou = OrganisationUser.find_by_user_id_and_organisation_id(params[:user_id].to_i, get_current_organisation.id.to_i)
    ou.destroy
    redirect_to :organisations, notice: "User removed from organisation."      # call index action

  end

  def edit_user

    @organisation_user = OrganisationUser.find_by_user_id_and_organisation_id(params[:user_id], get_current_organisation.id)
    @typesOptions = [['Quality', 0], ['Basic', 1], ['Owner', 2]]
    @user_id = @organisation_user.user_id
  end

  def update
    @organisation_user = OrganisationUser.find_by_user_id_and_organisation_id(params[:user_id], get_current_organisation.id)
    @organisation_user.update(user_type: params[:organisation_user][:user_type])


    @organisation_users = OrganisationUser.where(organisation_id: get_current_organisation.id, user_id: current_user.id)
    @organisation_user = OrganisationUser.new
    redirect_to :organisations, notice: "User type has been changed" 
  end

  def services
    @services = Service.all

    @selected_service = []
    OrganisationService.where(:organisation_id => get_current_organisation.id).each do |s|
      @selected_service << s.service_id
    end

  end

  def update_service
    services = JSON.parse(request.raw_post)

    #todo check previlige
    OrganisationService.where(:organisation_id => get_current_organisation.id).destroy_all
    Topic.where(:organisation_id => get_current_organisation.id).destroy_all
    Document.where(:organisation_id => get_current_organisation.id).destroy_all

    default_org_id = 1

    services.each do |id| 
      os = OrganisationService.new
      os.organisation_id = get_current_organisation.id
      os.service_id = id
      os.save
    end
    ts = TopicService.joins("inner join organisation_services on topic_services.service_id = organisation_services.service_id").where("organisation_services.organisation_id = " + get_current_organisation.id.to_s).pluck("distinct topic_services.topic_id")

    ts.each do |t|
      topic = Topic.find_by_id(t) 

      #copy topic
      new_topic = Topic.new
      new_topic.name = topic.name
      new_topic.description = topic.description
      new_topic.status = topic.status
      new_topic.organisation_id = get_current_organisation.id
      #new_topic.save

      #copy documents
      doc = Document.where(:organisation_id => default_org_id, :topic_id => t)
      doc.each do |d|
        new_doc = Document.new
        new_doc.title = d.title
        new_doc.status = d.status
        new_doc.content = d.content
        new_doc.assigned_to_all = d.assigned_to_all
        new_doc.user_id = current_user.id
        new_doc.organisation_id = get_current_organisation.id
        new_doc.document_type_id = d.document_type_id
        new_doc.doc_file_name = d.doc_file_name
        new_doc.doc_content_type = d.doc_content_type
        new_doc.doc_file_size = d.doc_file_size
        new_doc.doc_updated_at = d.doc_updated_at
        new_doc.major_version = d.major_version
        new_doc.minor_version = d.minor_version
        new_doc.do_update = d.do_update
        new_doc.change_control = d.change_control
        new_doc.review_date = Time.now + 1.years
        #new_doc.document_topic_id = 
        new_topic.documents << new_doc

        reivew = Review.new
        reivew.user_id = current_user.id
        reivew.status = 1
        reivew.major_version = new_doc.major_version
        reivew.minor_version = new_doc.minor_version

        new_doc.reviews << reivew

        approval = Approval.new
        approval.user_id = current_user.id
        approval.status = 1
        approval.major_version = new_doc.major_version
        approval.minor_version = new_doc.minor_version

        new_doc.approvals << approval

      end

      new_topic.save
    end

    respond_to do |format|
      format.json { render :json => true }
    end
  end

  def import
    @topics = Topic.where(:organisation_id => get_current_organisation.id)
  end

  def update_sops
    obj = JSON.parse(request.raw_post)

    obj["excluded_doc"].each do |d|
      Document.find_by_id(d).destroy()
    end

    obj["sign_off_users"].each do |d|
      doc = Document.find_by_id(d["doc_id"])
      doc.update(:status => d["doc_status"])

      trainee = Trainee.new
      trainee.user_id = d["user_id"]
      trainee.status = 0
      trainee.major_version = doc.major_version
      trainee.minor_version = doc.minor_version
      trainee.document_id = doc.id
      trainee.save

    end

    respond_to do |format|
      format.json { render :json => obj }
    end
  end
  private

  def prepare_index
    pending_user = PendingUser.where(email: current_user.email).first
    if !pending_user.nil?
      # Current user is in the PendingUser table
      # Automatically make current user of the organisation
      invited_user = OrganisationUser.new
      invited_user.user_id = User.where(email: current_user.email).first.id
      invited_user.accepted = true
      invited_user.user_type = pending_user.user_type.to_i
      invited_user.inviter_id = pending_user.inviter_id
      invited_user.organisation_id = pending_user.organisation_id
      invited_user.save
      
      pending_user.destroy
    end

    my_organisations = OrganisationUser.where(user_id: current_user.id)
    @organisations = []
    @organisation_invitations= []
    my_organisations.each do |ou|
      if ou.accepted
        @organisations << Organisation.find(ou.organisation_id)
      else
        @organisation_invitations << Organisation.find(ou.organisation_id)
      end
    end

  end

  def organisation_params
    params.require(:organisation).permit(:name, :gms_code, :user_id, :services)
  end
end
