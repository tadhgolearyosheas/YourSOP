class OrganisationsController < ApplicationController
  # autocomplete :user, :email

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
    params.require(:organisation).permit(:name, :gms_code, :user_id)
  end
end
