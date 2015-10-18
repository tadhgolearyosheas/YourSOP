require 'rails_helper'

RSpec.describe AuditReview, type: :model do
  apd = AuditReview.new()
	it "has a status 1" do
		apd.status = 1
		apd.status.should match(1)
	end
  
	it " has a audit_id 1" do
		apd.audit_id = 1
		apd.audit_id.should match(1)
	end
end
