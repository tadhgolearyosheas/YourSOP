require 'rails_helper'

RSpec.describe "audits/new", type: :view do
  before(:each) do
    assign(:audit, Audit.new(
      :status => 1,
      :result => 1
    ))
  end

  it "renders new audit form" do
    render

    assert_select "form[action=?][method=?]", audits_path, "post" do

      assert_select "input#audit_status[name=?]", "audit[status]"

      assert_select "input#audit_result[name=?]", "audit[result]"
    end
  end
end
