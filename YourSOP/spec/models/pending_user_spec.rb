require 'spec_helper'
require 'rails_helper'

RSpec.describe PendingUser, type: :model do

it "is valid without anything" do
    pendinguser = PendingUser.new
	expect(pendinguser).to be_valid
	end

describe PendingUser do 
	pu = PendingUser.new()
	it "has email '123@qq.com'" do
		pu.email = "123@qq.com"
		pu.email.should match("123@qq.com")
	end

	it "has user type 'reviewer'" do
		pu.user_type = "reviewer"
		pu.user_type.should match("reviewer")
	end

	it "has organisation id 1" do
		pu.organisation_id = 1
		pu.organisation_id.should match(1)
	end

	it "is created at today" do
		pu.created_at = Date.new
		pu.created_at.should match(Date.new)
	end

	it "is updated at today" do
		pu.updated_at = Date.new
		pu.updated_at.should match(Date.new)
	end

	it "is invited by user 13" do
		pu.inviter_id = 13
		pu.inviter_id.should match(13)
	end
  end
end