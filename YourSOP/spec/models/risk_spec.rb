require 'rails_helper'
require 'spec_helper'

describe Risk do
  r = Risk.new()
  it "has a score 20" do
    r.score = 20
    r.score.should match(20)
  end
    it "has a desc 'topic description shows exact details'" do
      r.desc = "topic description shows exact details"
      r.desc.should match("topic description shows exact details")
  end
  it "has a status 1" do
    r.status = 1
    r.status.should match(1)
  end
  
  
end