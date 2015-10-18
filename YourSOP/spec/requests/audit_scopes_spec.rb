require 'rails_helper'

RSpec.describe "AuditScopes", type: :request do
  describe "GET /audit_scopes" do
    it "works! (now write some real specs)" do
      get audit_scopes_path
      expect(response).to have_http_status(200)
    end
  end
end
