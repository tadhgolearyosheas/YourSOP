class HomeController < ApplicationController

  before_action :check_current_organisation 

	def index
		get_mailbox
		#@audit_report = AuditReport.new(user: current_user, organisation: get_current_organisation.id, role: OrganisationUser.where(user: current_user, organisation: get_current_organisation)[0].user_type)
		
		@home = @mailbox.inbox.paginate(page: params[:page], per_page: 6)
      
		@my_actions = AuditsPracticesAction.joins(audits_practice: { audit: :topic }).where("topics.organisation_id = ? and audits.status = ? and audits_practices_actions.user_id = ? and  audits_practices_actions.status = ?", get_current_organisation.id, 5, current_user.id, 0)
		
		@documents_for_review = Document.joins(:reviews).where("documents.organisation_id = ? and documents.status = 1 and reviews.status = 0 and reviews.user_id = ?", get_current_organisation.id, current_user.id);
		@documents_for_approval = Document.joins(:approvals).where("documents.organisation_id = ? and documents.status = 2 and approvals.status = 0 and approvals.user_id = ?", get_current_organisation.id, current_user.id);
		@documents_for_trainee = Document.joins(:trainees).where("documents.organisation_id = ? and documents.status = 3 and trainees.status = 0 and trainees.user_id = ?", get_current_organisation.id, current_user.id);

		@audits_for_review = Audit.joins(:topic, :audit_reviews).where("topics.organisation_id = ? and audits.status = 1 and audit_reviews.status = 0 and audit_reviews.user_id = ?", get_current_organisation.id, current_user.id);
		@audits_for_approval = Audit.joins(:topic, :audit_approvals).where("topics.organisation_id = ? and audits.status = 2 and audit_approvals.status = 0 and audit_approvals.user_id = ?", get_current_organisation.id, current_user.id);
	end

  	def get_notification
	    @notifications ||= @mailbox.conversations.find(params[:id])
	end

	def mark_as_read
		get_mailbox
		get_conversation
	    @conversation.mark_as_read(current_user)
	    redirect_to root_path
	end

	def save_audit_action
		action = AuditsPracticesAction.find(params[:id]);

		if action.user_id == current_user.id #check authority
			finished = params[:status] == "1" ? 1 : 0;
			action.update(status: finished, comment: params[:comment])
			flash[:success] = 'Success'
		else
			flash[:danger] = 'You do not have right to do this operation!'

		end
		redirect_to root_path
	end


private
	
	def get_mailbox
    	@mailbox ||= current_user.mailbox
  	end

  	def get_conversation
    	@conversation ||= @mailbox.conversations.find(params[:id])
  	end
end
