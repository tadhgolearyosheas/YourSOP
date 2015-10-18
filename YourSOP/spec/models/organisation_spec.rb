require 'spec_helper'
require 'rails_helper'

RSpec.describe Organisation, type: :model do

it "is valid with name" do
    organisation = Organisation.new
    organisation.name = "University of Adelaide"
	expect(organisation).to be_valid
end
it "is invalid with out name" do
	organisation = Organisation.new
	organisation.name = nil
	expect(organisation).not_to be_valid
end

describe Organisation do 
	org = Organisation.new()
	it "has a name 'test'" do
		org.name = "test"
		org.name.should match("test")
	end
	
	it "is created by user with id 12" do
		org.user_id = 12
		org.user_id.should match(12)
	end

	it "is created at today" do
		org.created_at = Date.new
		org.created_at.should match(Date.new)
	end

	it "is updated at today" do
		org.updated_at = Date.new
		org.updated_at.should match(Date.new)

	end
 end
end