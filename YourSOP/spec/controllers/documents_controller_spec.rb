require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do

describe "GET #index" do
    it "set document filter when it is empty" do
      get :index
	  get_document_filter == nil
	  assigns(:set_document_filter).should eq([@@DF_YOUR_DOCUMENTS])
    end
	
	 it "set status filter when it is empty" do
      get :index
	  get_status_filter == nil
	  assigns(:set_status_filter).should eq([@@STATUS_DRAFT])
    end

	
	 it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

describe "GET #show" do
	 it "renders the show template" do
      get :setup_show
      expect(response).to render_template("show")
    end
end

describe "GET #new" do
     it "can not create documents when the user is basic user" do
	  user1 = assigns[:user=>current_user[0],:organisation=>get_current_organisation[0]]
      assigns[:user1.user_type]== @@USER_TYPE_BASIC
	  expect(response).to redirect_to (document)
      flash[:notice].should eq('Basic user accounts cannot create documents.')
	  end
  end

describe "GET #create" do
    before (:each) do
	@document = Document.new(document_params)
    @document.organisation = get_current_organisation
    @document.status = @@STATUS_DRAFT

    @document.major_version = "0"
    @document.minor_version = "1"
    @document.do_update = false
    @document.change_control = "Initial creation."
	end
	
	it "can not create documents when the document already exist" do
	  assigns[:save]==false
	  expect(response).to redirect_to(:action => 'new')
      flash[:alert].should eq('Document could not be created')
	  end

    it "return to index when document was created" do
	  assigns(:params,[:document],[:assigned_to_all]) != nil
	  expect(response).to redirect_to(:action => 'new')
	  flash[:notice].should eq('Document was successfully created.')
	end	
end

describe "GET #edit" do
    it "can not edit document when you are not the editor " do
	 assigns[:user=>current_user] != document.user
	  expect(response).to redirect_to(:action => 'index')
	  flash[:warning].should eq('You can only edit documents that are in the Draft state.')
    end
	
	it "can not edit document when document is not the draft state " do
	  assigns[:status] != 0
	  expect(response).to redirect_to(:action => 'index')
	  flash[:warning].should eq('You can only edit documents that are in the Draft state.')
    end

end

describe "GET #destroy" do
    it "delete the document when it was found" do
      assgns[:document] == true
      expect(response).to redirect_to(documents_path)
	  flash[:success].should eq('Document was successfully deleted.')
    end	  

    it "can not delete document when it can be found" do
      assgns[:document] == false
      expect(response).to redirect_to(documents_path)
	  flash[:danger].should eq('Document was not deleted.')
    end	
 end	

  end