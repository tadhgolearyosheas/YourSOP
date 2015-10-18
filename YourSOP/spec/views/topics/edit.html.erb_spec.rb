require 'rails_helper'

RSpec.describe "topics/edit", type: :view do
  before(:each) do
    @topic = assign(:topic, Topic.create!(
      :name => "MyString",
      :description => "MyString",
      :status => 1
    ))
  end

  it "renders the edit topic form" do
    render

    assert_select "form[action=?][method=?]", topic_path(@topic), "post" do

      assert_select "input#topic_name[name=?]", "topic[name]"

      assert_select "input#topic_description[name=?]", "topic[description]"

      assert_select "input#topic_status[name=?]", "topic[status]"
    end
  end
end
