require "rails_helper"

RSpec.describe AuditsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/audit_scopes").to route_to("audit_scopes#index")
    end

    it "routes to #new" do
      expect(:get => "/audit_scopes/new").to route_to("audit_scopes#new")
    end

    it "routes to #show" do
      expect(:get => "/audit_scopes/1").to route_to("audit_scopes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/audit_scopes/1/edit").to route_to("audit_scopes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/audit_scopes").to route_to("audit_scopes#create")
    end

    it "routes to #update" do
      expect(:put => "/audit_scopes/1").to route_to("audit_scopes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/audit_scopes/1").to route_to("audit_scopes#destroy", :id => "1")
    end

  end
end
