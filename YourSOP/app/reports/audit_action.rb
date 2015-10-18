class AuditAction < Dossier::Report

	def sql
		q =  "select 
				topics.name as topic,
				audits.start_date,
				audits.end_date,
				audits_practices_actions.action,
				users.email as action_by,
				audits_practices_actions.status,
				audits_practices_actions.comment
				from audits 
				inner join audits_practices on audits.id = audits_practices.audit_id 
				inner join audits_practices_actions on audits_practices_actions.audits_practice_id = audits_practices.id
				inner join topics on audits.topic_id = topics.id
				inner join users on audits_practices_actions.user_id = users.id
				where topics.organisation_id = " + options[:organisation].to_s + " and audits.start_date > CURRENT_DATE - 365 "
		q = q + " order by audits.created_at desc "
		return q
	end

	def format_status(status)
	    if status == "0"
	        'OnGoing'
	    elsif status == "1"
	        'Finished'
	    else
	        'Unknown'
	    end
	end

	def format_start_date(value)
		value == nil ? '' : value.to_date
	end

	def format_end_date(value)
		value == nil ? '' : value.to_date
	end

end