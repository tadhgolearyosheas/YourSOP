require 'rails_helper'

RSpec.describe "audits/index", type: :view do
  before(:each) do
    assign(:audits, [
      Audit.create!(
        :status => 1,
        :result => 2
      ),
      Audit.create!(
        :status => 1,
        :result => 2
      )
    ])
  end

  it "renders a list of audits" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
