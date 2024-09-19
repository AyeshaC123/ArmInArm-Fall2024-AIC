require 'test_helper'

class ReviewControllerTest < ActionDispatch::IntegrationTest
  test "should get review" do
    get review_review_url
    assert_response :success
  end

end
