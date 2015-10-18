require 'rails_helper'

RSpec.describe RisksDetail, type: :model do

	it "is invalid without a title" do
    	rd = RisksDetail.new(title: nil)
    	expect(rd).not_to be_valid
  	end

	it "is invalid without a impact" do
    	rd = RisksDetail.new(impact: nil)
    	expect(rd).not_to be_valid
  	end
	
	it "is invalid without a likelihood" do
    	rd = RisksDetail.new(likelihood: nil)
    	expect(rd).not_to be_valid
  	end
end
