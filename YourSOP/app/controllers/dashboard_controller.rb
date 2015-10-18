class DashboardController < ApplicationController

	before_action :check_current_organisation 

	def index

		#@user_type = OrganisationUser.where(user: current_user, organisation: @current_organisation)[0].user_type


		@audit_report = AuditReport.new(organisation: get_current_organisation.id)

		@audit_action = AuditAction.new(organisation: get_current_organisation.id)

		@current_user = current_user
	end

	def audit_this_year
		render json: Audit.joins(:topic).where("topics.organisation_id = ? and audits.start_date > CURRENT_DATE - 365", @current_organisation.id).group("topics.name").count
	end

	def topic_risk_trend
		render json: Risk.joins(:topic).where("topics.organisation_id = ? and risks.created_at > CURRENT_DATE - 365", @current_organisation.id).group("topics.name").group("risks.created_at").sum("risks.score").chart_json
	end

	def document_status
		render json: Document.where(organisation_id: @current_organisation.id).group("case status when 0 then 'draft' when 1 then 'reivew' when 2 then 'approval' when 3 then 'Effective' end ").count()
	end

	def audit_result
		render json: Audit.joins(:topic).where("topics.organisation_id = ? and audits.start_date > CURRENT_DATE - 365", @current_organisation.id).group("case audits.result when 1 then 'Green' when 2 then 'Amber' when 3 then 'Red' end ").count
	end

end
