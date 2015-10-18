require 'rails_helper'

RSpec.describe AuditsPractice, type: :model do
  apd = AuditsPractice.new()
	it "has a audit_id 35" do
		apd.audit_id = 35
		apd.audit_id.should match(35)
	end
  	it " has a result 1" do
		apd.result = 1
		apd.result.should match(1)
	end
	
end
