require "application_system_test_case"

class AdminTest < ApplicationSystemTestCase
  setup do
    @user = {
      name: "Tramplesauce",
      email: "imagine.magics@example.com"
    }
  end

  test "cannot access admin screen" do
    visit admin_root_path
    assert_current_path guests_sign_in_path
  end
end
