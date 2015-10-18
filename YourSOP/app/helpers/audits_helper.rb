module AuditsHelper
	def topic_status_to_string status
        if status == 0
            'Draft'
        elsif status == 1
            'For Review'
        elsif status == 2
            'For Approval'
        elsif status == 3
            'Approved'
        elsif status == 4
            'Auditing'
        elsif status == 5
            'Finished'
        else
            'Unknown'
        end
     end

     def audit_result_to_string result
        if result == 1
            'Green'
        elsif result == 2
            'Amber'
        elsif result == 3
            'Red'
        else
            'Unknown'
        end
     end

end
