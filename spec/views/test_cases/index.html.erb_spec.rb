require 'spec_helper'

describe "test_cases/index" do
  before(:each) do
    assign(:test_cases, [
      stub_model(TestCase,
        :input => "MyText",
        :output => "MyText"
      ),
      stub_model(TestCase,
        :input => "MyText",
        :output => "MyText"
      )
    ])
  end

  it "renders a list of test_cases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
