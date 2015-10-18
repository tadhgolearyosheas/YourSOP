require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

 describe "#is_owner?" do
    it "is true when the type is the user type" do
       let(:type) { '2' }
      expect(type).to eq(@@USER_TYPE_OWNER)
    end
  end
  
  describe "#is_quality?" do
    it "is true when the type is the user type" do
       let(:type) { '0' }
      expect(type).to eq(@@USER_TYPE_QUALITY)
    end
  end
  
  describe "#is_basic?" do
    it "is true when the type is the user type" do
       let(:type) { '1' }
      expect(type).to eq(@@USER_TYPE_BASIC)
    end
  end
  
 describe "#set_current_organisation_id?" do
    it "set the current_organisation_id" do
       session[:current_organisation_id] = org_id
    end
  end


describe "#get_current_organisation?" do
    it "return nil if current_organisation_id is nil" do
	   assigns[:current_organisation_id]== nil
	   expect(response).to eq("nil")
    end
  end

describe "#setup_header?" do
    it "should return false if the current organization is nil" do
	   assigns[:current_organisation]== nil
	   expect(response).to eq("false")
    end
 

    it "should success when data is right" do
	    ou = assigns[:user=>current_user,:organisation=>@current_organisation]
        expect(response).to be_success
    end
end

describe "#check_current_organisation?" do
    it "should select a organization when the get_current_organisation is nil " do
         assigns[:get_current_organisation]== nil
		 expect(response).to redirect_to (root_path(assigns(:notice=>'You must select an organisation before viewing documents')))                               
    end
  end
 
 describe "#check_current_user_is_owner?" do
 it "should notice cannot manage document types when user is not owner" do
	    user1 = assigns[:user=>current_user,:organisation=>@current_organisation.user_type]
        assigns [:user1.type] != @@USER_TYPE_OWNER 
		expect(response).to redirect_to (root_path(assigns(:notice=>'Only owner accounts can manage document types.')))
    end
end

 
 end