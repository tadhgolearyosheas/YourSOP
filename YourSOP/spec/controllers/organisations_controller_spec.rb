require 'rails_helper'

RSpec.describe OrganisationsController, type: :controller do

 describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end


 describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end
  
 describe "GET #invite" do
    it "can invite users when it is owner" do
      assigns[current_user_is_owner]== true
      expect(response).to redirect_to(organisations)
      flash[:notice].should eq('Only owners can invite users.')
    end
  end

 describe "GET #inviteSubmission" do
 
    it " invite Unregistered users " do
      assigns(:email => selected_email).first== nil
      expect(response).to redirect_to(organisations)
      flash[:notice].should eq('Unregistered user has been invited.')
    end
	
	it " invite registered users " do
      assigns(:email => selected_email).first!= nil
      expect(response).to redirect_to(organisations)
      flash[:notice].should eq('Registered user has been invited.')
    end
  end
  
 describe "GET #users" do
    it "returns http success" do
      get :users
      expect(response).to have_http_status(:success)
    end
  end 
  
 describe "GET #save_current_organisation" do
    it "returns http success" do
      get :save_current_organisation
      expect(response).to have_http_status(:success)
    end
  end 
  
 describe "GET #accept_organisation_invitation" do
    it "returns http success" do
      get :accept_organisation_invitation
      expect(response).to have_http_status(:success)
    end
  end 
  
 describe "GET #decline_organisation_invitation" do
    it "returns http success" do
      get :decline_organisation_invitation
      expect(response).to have_http_status(:success)
    end
  end 
  
 describe "GET #remove_user" do
    it "returns http success" do
      get :remove_user
      expect(response).to have_http_status(:success)
    end
  end 
  
 describe "GET #organisation_params" do
    it "returns http success" do
      get :organisation_params
      expect(response).to have_http_status(:success)
    end
  end 


end