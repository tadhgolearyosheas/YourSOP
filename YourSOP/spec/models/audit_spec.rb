require 'rails_helper'

RSpec.describe Audit, type: :model do
 apd = Audit.new()
	it "has a status 2" do
		apd.status = 2
		apd.status.should match(2)
	end
  	it " has a result 30" do
		apd.result = 30
		apd.result.should match(30)
	end
	it " has a topic_id 1" do
		apd.topic_id = 1
		apd.topic_id.should match(1)
	end
end
