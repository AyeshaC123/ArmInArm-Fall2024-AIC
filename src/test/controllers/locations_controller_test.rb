require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get locations_page" do
    get locations_locations_page_url
    assert_response :success
  end

end
