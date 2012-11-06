require 'spec_helper'

describe "test_cases/show" do
  before(:each) do
    @test_case = assign(:test_case, stub_model(TestCase,
      :input => "MyText",
      :output => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
