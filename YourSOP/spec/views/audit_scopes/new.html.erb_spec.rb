require 'rails_helper'

RSpec.describe "audit_scopes/new", type: :view do
  before(:each) do
    assign(:audit_scope, AuditScope.new(
      :name => "MyString",
      :status => 1,
      :sequence => 1
    ))
  end

  it "renders new audit_scope form" do
    render

    assert_select "form[action=?][method=?]", audit_scopes_path, "post" do

      assert_select "input#audit_scope_name[name=?]", "audit_scope[name]"

      assert_select "input#audit_scope_status[name=?]", "audit_scope[status]"

      assert_select "input#audit_scope_sequence[name=?]", "audit_scope[sequence]"
    end
  end
end
