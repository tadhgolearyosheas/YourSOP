require 'spec_helper'
require 'rails_helper'

RSpec.describe Review, type: :model do

it "is valid without anything" do
    review = Review.new
	expect(review).to be_valid
	end

describe Review do 
	rev = Review.new()
	it "has status 1" do
		rev.status = 1
		rev.status.should match(1)
	end

	it "has document id 12" do
		rev.document_id = 12
		rev.document_id.should match(12)
	end

	it "has user id 13" do
		rev.user_id = 13
		rev.user_id.should match(13)
	end

	it "is created at today" do
		rev.created_at = Date.new
		rev.created_at.should match(Date.new)
	end

	it "is updated at today" do
		rev.updated_at = Date.new
		rev.updated_at.should match(Date.new)
	end
end

end