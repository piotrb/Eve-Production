require 'spec_helper'

describe "characters/show.html.erb" do
  before(:each) do
    @character = assign(:character, stub_model(Character,
      :name => "Name",
      :charid => 1,
      :pe_skill => 1,
      :industry_skill => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
