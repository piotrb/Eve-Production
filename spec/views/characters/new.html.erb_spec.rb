require 'spec_helper'

describe "characters/new.html.erb" do
  before(:each) do
    assign(:character, stub_model(Character,
      :name => "MyString",
      :charid => 1,
      :pe_skill => 1,
      :industry_skill => 1
    ).as_new_record)
  end

  it "renders new character form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => characters_path, :method => "post" do
      assert_select "input#character_name", :name => "character[name]"
      assert_select "input#character_charid", :name => "character[charid]"
      assert_select "input#character_pe_skill", :name => "character[pe_skill]"
      assert_select "input#character_industry_skill", :name => "character[industry_skill]"
    end
  end
end
