require 'rails_helper'

RSpec.describe RisksImpact, type: :model do
  apd = RisksImpact.new()
	it "has a name 'moderate'" do
		apd.name = "moderate"
		apd.name.should match("moderate")
	end
  	it " has a description " do
		apd.description = "need some suggestions"
		apd.description.should match("need some suggestions")
	end
	it " has a value 25" do
		apd.value = 25
		apd.value.should match(25)
	end
end
