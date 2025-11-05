require "test_helper"

class PartiesControllerTest < ActionDispatch::IntegrationTest
  # Skipping this test because RSVP deadline checking is currently disabled
  # (see PartiesController line 2 - before_action is commented out)
  # Uncomment this test if you enable the redirect_because_rsvps_are_closed before_action
  # test "should NOT get rsvp because rsvps are closed" do
  #   get new_party_url
  #   assert_redirected_to root_path
  # end
end
