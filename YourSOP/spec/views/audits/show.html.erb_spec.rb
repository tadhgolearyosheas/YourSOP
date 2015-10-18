require 'rails_helper'

RSpec.describe "audits/show", type: :view do
  before(:each) do
    @audit = assign(:audit, Audit.create!(
      :status => 1,
      :result => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
