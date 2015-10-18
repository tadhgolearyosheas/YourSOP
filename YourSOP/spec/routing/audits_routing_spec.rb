require "rails_helper"

RSpec.describe AuditsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/audits").to route_to("audits#index")
    end

    it "routes to #new" do
      expect(:get => "/audits/new").to route_to("audits#new")
    end

    it "routes to #show" do
      expect(:get => "/audits/1").to route_to("audits#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/audits/1/edit").to route_to("audits#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/audits").to route_to("audits#create")
    end

    it "routes to #update" do
      expect(:put => "/audits/1").to route_to("audits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/audits/1").to route_to("audits#destroy", :id => "1")
    end

  end
end
