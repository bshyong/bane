require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "abbreviations" do
    get(:process_input, {'input' => 'INPUT'}
    assert_equal(:output, 'OUTPUT')
  end

end
