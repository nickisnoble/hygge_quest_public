require "test_helper"

class PartiesControllerTest < ActionDispatch::IntegrationTest
  test "should NOT get rsvp because rsvps are closed" do
    get new_party_url
    assert_redirected_to root_path
  end
end
