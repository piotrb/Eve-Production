require 'spec_helper'

describe "characters/index.html.erb" do
  before(:each) do
    assign(:characters, [
      stub_model(Character,
        :name => "Name",
        :charid => 1,
        :pe_skill => 1,
        :industry_skill => 1
      ),
      stub_model(Character,
        :name => "Name",
        :charid => 1,
        :pe_skill => 1,
        :industry_skill => 1
      )
    ])
  end

  it "renders a list of characters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
