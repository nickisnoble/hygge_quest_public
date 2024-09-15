require "test_helper"

class PwaControllerTest < ActionDispatch::IntegrationTest
  test "should get service_worker" do
    get pwa_service_worker_url
    assert_response :success
  end

  test "should get manifest" do
    get pwa_manifest_url
    assert_response :success
  end
end
