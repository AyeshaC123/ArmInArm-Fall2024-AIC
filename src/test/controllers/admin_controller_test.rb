require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get schedule_generator" do
    get admin_schedule_generator_url
    assert_response :success
  end

end
