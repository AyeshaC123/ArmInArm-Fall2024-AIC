require 'test_helper'

class VolunteersControllerTest < ActionDispatch::IntegrationTest
  test "should get upcoming_hours" do
    get volunteers_upcoming_hours_url
    assert_response :success
  end

  test "should get form" do
    get volunteers_form_url
    assert_response :success
  end

end
