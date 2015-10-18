require 'rails_helper'

RSpec.describe "audit_scopes/show", type: :view do
  before(:each) do
    @audit_scope = assign(:audit_scope, AuditScope.create!(
      :name => "Name",
      :status => 1,
      :sequence => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
