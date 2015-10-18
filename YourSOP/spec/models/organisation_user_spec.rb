require 'spec_helper'
require 'rails_helper'

RSpec.describe OrganisationUser, type: :model do

it "is valid without anything" do
    organisation_user = OrganisationUser.new
	expect(organisation_user).to be_valid
	end


describe OrganisationUser do 
	orguser = OrganisationUser.new()
	it "is accepted" do
		orguser.accepted = true
		orguser.accepted.should match(true)
	end

	it "has user type 0" do
		orguser.user_type = 0
		orguser.user_type.should match(0)
	end

	it "has user id 13" do
		orguser.user_id = 13
		orguser.user_id.should match(13)
	end

	it "has organisation id 14" do
		orguser.organisation_id = 14
		orguser.organisation_id.should match(14)
	end

	it "is created at today" do
		orguser.created_at = Date.new
		orguser.created_at.should match(Date.new)
	end

	it "is updated_at today" do
		orguser.updated_at = Date.new
		orguser.updated_at.should match(Date.new)
	end

	it "is invited by user 12" do
		orguser.inviter_id = 12
		orguser.inviter_id.should match(12)
	end
end	

end