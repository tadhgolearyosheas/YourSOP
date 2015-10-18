require 'rails_helper'

RSpec.describe AuditApproval, type: :model do
  ap = AuditApproval.new()
	it "has a status 2" do
		ap.status = 2
		ap.status.should match(2)
	end
  	
	it " has a audit_id 1" do
		ap.audit_id = 1
		ap.audit_id.should match(1)
	end

	it "has a user_id 5" do
		ap.user_id = 5
		ap.user_id.should match(5)
	end
end
