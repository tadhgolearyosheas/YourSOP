require 'rails_helper'

RSpec.describe "audits/edit", type: :view do
  before(:each) do
    @audit = assign(:audit, Audit.create!(
      :status => 1,
      :result => 1
    ))
  end

  it "renders the edit audit form" do
    render

    assert_select "form[action=?][method=?]", audit_path(@audit), "post" do

      assert_select "input#audit_status[name=?]", "audit[status]"

      assert_select "input#audit_result[name=?]", "audit[result]"
    end
  end
end
