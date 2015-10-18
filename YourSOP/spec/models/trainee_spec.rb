require 'spec_helper'
require 'rails_helper'

RSpec.describe Trainee, type: :model do

it "is valid with document_id, user_id, created_at, updated_at" do
    trainee = Trainee.new
    trainee.document_id = 5
    trainee.user_id = 2
    trainee.created_at = Date.today
    trainee.updated_at =Date.today
	expect(trainee).to be_valid
end


describe Reader do 
	rd = Trainee.new()

	it "has document id 13" do
		rd.document_id = 13
		rd.document_id.should match(13)
	end

	it "has user id 12" do
		rd.user_id = 12
		rd.user_id.should match(12)
	end

	it "is created at today" do
		rd.created_at = Date.new
		rd.created_at.should match(Date.new)
	end

	it "is updated at today" do
		rd.updated_at = Date.new
		rd.updated_at.should match(Date.new)
	end
	
end

end