require 'rails_helper'

RSpec.describe AuditsPracticesAction, type: :model do
  apd = AuditsPracticesAction.new()
	it "has a status 2" do
		apd.status = 2
		apd.status.should match(2)
	end
  	it " has a comment 'everything is okay'" do
		apd.comment = "everything is okay"
		apd.comment.should match("everything is okay")
	end
	it " has a audits_practice_id 1" do
		apd.audits_practice_id = 1
		apd.audits_practice_id.should match(1)
	end
	it " has an action 'passed'" do
		apd.action = "passed"
		apd.action.should match("passed")
	end
end
