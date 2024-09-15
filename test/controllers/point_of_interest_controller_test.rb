require "test_helper"

class PointOfInterestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get point_of_interest_index_url
    assert_response :success
  end
end
