require 'spec_helper'
require 'rails_helper'

describe Topic do
	topic = Topic.new()
	it "has a name 'X-ray'" do
		topic.name = "X-ray"
		topic.name.should match("X-ray")
	end
    it "has a description 'topic description shows exact details'" do
    	topic.description = "topic description shows exact details"
	    topic.description.should match("topic description shows exact details")
	end
	it " has a status 1" do
		topic.status = 1
		topic.status.should match(1)
	end
	it "is invalid without a name" do
		expect(build(:topic, name: nil)).not_to be_valid
	end
	it "is invalid without a status" do
		expect(build(:topic, status: nil)).not_to be_valid
	end
	it "is invalid without a description" do
		expect(build(:topic, description: nil)).not_to be_valid
	end
	it "is valid with a name" do
		expect(build(:topic, name: "Room Name")).to be_valid
	end
end