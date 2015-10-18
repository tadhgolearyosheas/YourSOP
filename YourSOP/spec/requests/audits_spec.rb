require 'rails_helper'

RSpec.describe "Audits", type: :request do
  describe "GET /audits" do
    it "works! (now write some real specs)" do
      get audits_path
      expect(response).to have_http_status(200)
    end
  end
end
