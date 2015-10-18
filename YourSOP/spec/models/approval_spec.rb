require 'spec_helper'
require 'rails_helper'

RSpec.describe Approval, type: :model do

it "is valid without anything" do
    ap = Approval.new
	expect(ap).to be_valid
end


describe Approval do
	app = Approval.new() 
	it "has a status 1" do
		app.status = 1
		app.status.should match(1)
	end

	it "has a document_id 12" do
		app.document_id = 12
		app.document_id.should match(12)
	end

	it "has a user id 12" do
		app.user_id = 12
		app.user_id.should match(12)
	end

	it "is created at today" do
		app.created_at = Date.new
		app.created_at.should match(Date.new)
	end

	it "is updated at today" do
		app.updated_at = Date.new
		app.updated_at.should match(Date.new)

	end
 end
end