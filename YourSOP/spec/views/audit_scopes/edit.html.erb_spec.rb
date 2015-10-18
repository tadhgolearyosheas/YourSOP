require 'rails_helper'

RSpec.describe "audit_scopes/edit", type: :view do
  before(:each) do
    @audit_scope = assign(:audit_scope, AuditScope.create!(
      :name => "MyString",
      :status => 1,
      :sequence => 1
    ))
  end

  it "renders the edit audit_scope form" do
    render

    assert_select "form[action=?][method=?]", audit_scope_path(@audit_scope), "post" do

      assert_select "input#audit_scope_name[name=?]", "audit_scope[name]"

      assert_select "input#audit_scope_status[name=?]", "audit_scope[status]"

      assert_select "input#audit_scope_sequence[name=?]", "audit_scope[sequence]"
    end
  end
end
