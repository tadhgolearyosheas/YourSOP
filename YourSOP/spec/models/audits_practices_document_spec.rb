

require 'spec_helper'
require 'rails_helper'

describe AuditsPracticesDocument do
	apd = AuditsPracticesDocument.new()
	it "has a document_id 35" do
		apd.document_id = 35
		apd.document_id.should match(35)
	end
  	it " has a major_version 1" do
		apd.major_version = 1
		apd.major_version.should match(1)
	end
	it " has a audits_practice_id 1" do
		apd.audits_practice_id = 1
		apd.audits_practice_id.should match(1)
	end
	
end
