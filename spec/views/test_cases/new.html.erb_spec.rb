require 'spec_helper'

describe "test_cases/new" do
  before(:each) do
    assign(:test_case, stub_model(TestCase,
      :input => "MyText",
      :output => "MyText"
    ).as_new_record)
  end

  it "renders new test_case form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => test_cases_path, :method => "post" do
      assert_select "textarea#test_case_input", :name => "test_case[input]"
      assert_select "textarea#test_case_output", :name => "test_case[output]"
    end
  end
end
