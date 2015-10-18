
require 'rails_helper'

RSpec.describe Document, type: :model do

it "is valid with id, title, status, doc_content_type, content, review_date, " do
#assigned_to_all, user_id, organisation_id, document_type_id, created_at, updated_at, doc_file_name, doc_file_size, doc_updated_at, major_version, minor_version, do_update, change_control, 

    document = Document.new(
	title: "results",
	status: 1 ,
	doc_content_type: "JPG",
	content: "hello pitty",
	review_date: "Sat, 30 May 2015",
	assigned_to_all: nil,
	user_id: nil)


    expect(document).to be_valid
	end
	

end

require 'spec_helper'
require 'rails_helper'

describe Document do 

	doc = Document.new

	#it "is reviewed at Sun, 24 May 2015" do
		#doc.review_date = "Sun, 24 May 2015"
		#doc.review_date.should match("Sun, 24 May 2015")
	#end

	it "has valide title 'title1' " do
		doc.title = "title1"
		doc.title.should match("title1")
	end

	it "has valide status 'draft'" do
		doc.status = 0
		doc.status.should match(0)
	end

	#it "accepts good review_dates" do
	#	doc.review_date = "06/04/2018"
	#	doc.review_date.should be_valid
	 #   doc.review_date.should==Date.parse(review_date)
	#end


	it "has valide content 'aaaa'" do
		doc.content = "aaaa"
		doc.content.should match("aaaa")
	end

	it "is visible to all users" do
		doc.assigned_to_all = true
		doc.assigned_to_all.should match(true)
	end

	it "is created by user with id '12'" do
		doc.user_id = 12
		doc.user_id.should match(12)
	end

	it "is under orgnisation with id '1" do
		doc.organisation_id = 1
		doc.organisation_id.should match(1)
	end

	it "is under type of '1" do
		doc.document_type_id = 1
		doc.document_type_id.should match(1)
	end

	it "is created at doc.datetime" do
		doc.created_at = Time.new
		doc.created_at.should match(doc.created_at)
	end

	it "is updated at doc.updatetime" do
		doc.updated_at = Time.new
		doc.updated_at.should match(doc.updated_at)
	end

	it "has file name 'test" do
		doc.doc_file_name = "test"
		doc.doc_file_name.should match("test")
	end

	it "has content type 'direction'" do
		doc.doc_content_type = "direction"
		doc.doc_content_type.should match("direction")
	end

	it "has a file size as 255" do
		doc.doc_file_size = 255
		doc.doc_file_size.should match(255)
	end

	it "is updated at doc.doc_updated_at" do
		doc.doc_updated_at = Time.new
		doc.doc_updated_at.should match(doc.doc_updated_at)
	end

	it "has a major version 1.0" do
		doc.major_version = "1.0"
		doc.major_version.should match("1.0")
	end

	it "has a minor version 0.1" do
		doc.minor_version = "0.1"
		doc.minor_version.should match("0.1")
	end

	it "is update or not" do
		doc.do_update = true
		doc.do_update.should match(true)
	end

	it "change control to 'initial'" do
		doc.change_control = "initial"
		doc.change_control.should match("initial")
	end

end

