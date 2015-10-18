class AuditReport < Dossier::Report

  # all roles share the same report
  def sql
    q = 'select o.name as department, t.name as topic, a.start_date, a.end_date, a.status, a.result,
		a.id as action
		from topics t 
		inner join audits a on t.id = a.topic_id 
		inner join organisations o on t.organisation_id = o.id '

	#if options[:role] == 0 #quality
		q = q + ' where a.status != 0 and t.organisation_id = ' + options[:organisation].to_s + ' and a.start_date > CURRENT_DATE - 365 '
	#end

	#if options[:role] == 1 #basic
		#q = 'select distinct o.name as department, t.name as topic, a.start_date, a.end_date, a.status, a.result,
		#		a.id as action
		#		from topics t 
		#		inner join audits a on t.id = a.topic_id 
		#		inner join organisations o on t.organisation_id = o.id
		#		inner join audits_practices ap on a.id = ap.audit_id
		#		inner join audits_practices_actions apa on ap.id = apa.audits_practice_id
		#		inner join audits_practices_documents apd on ap.id = apd.audits_practice_id
		#		inner join documents d on apd.document_id = d.id
		#		where apa.user_id = ' + options[:user].id.to_s + ' or d.user_id = ' + options[:user].id.to_s + ' and a.start_date > CURRENT_DATE - 365 '
	#end

	q = q + ' order by a.start_date desc '
	return q
  end

  def format_action(value)
    "<a href='/audits/" + value.to_s + "' target='_blank' >View Audit Report</a>"
  end

  def format_result(value)
  	audit_result_to_string value
  end

  def format_status(status)
    if status == "0"
        'Draft'
    elsif status == "1"
        'For Review'
    elsif status == "2"
        'For Approval'
    elsif status == "3"
        'Approved'
    elsif status == "4"
        'Auditing'
    elsif status == "5"
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

private 

	def audit_result_to_string result
        if result == "1"
            'Green'
        elsif result == "2"
            'Amber'
        elsif result == "3"
            'Red'
        else
            'Unknown'
        end
     end

end