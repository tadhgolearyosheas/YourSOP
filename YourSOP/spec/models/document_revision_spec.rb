require 'spec_helper'
require 'rails_helper'

RSpec.describe DocumentRevision, type: :model do

it "is valid without anything" do
    documentr = DocumentRevision.new
	expect(documentr).to be_valid
end	

describe DocumentRevision do
	docrevi = DocumentRevision.new() 
	it "has major_version 1.0" do
		docrevi.major_version = 1.0
		docrevi.major_version.should match(1.0)
	end

	it "has minor_version 1.0" do
		docrevi.minor_version = 1.0
		docrevi.minor_version.should match(1.0)
	end

	it "has content 'aaaa'" do
		docrevi.content = "aaaa"
		docrevi.content.should match("aaaa")
	end

	it "change control to reviewer" do
		docrevi.change_control = "reviewed"
		docrevi.change_control.should match("reviewed")
	end

	it "has document id 12" do
		docrevi.document_id = 12
		docrevi.document_id.should match(12)
	end

	it "is created at today" do
		docrevi.created_at = Date.new
		docrevi.created_at.should match(Date.new)
	end

	it "is updated at today" do
		docrevi.updated_at = Date.new
		docrevi.updated_at.should match(Date.new)

	end
 end
end