require "application_system_test_case"

class DungeonMasterTest < ApplicationSystemTestCase
  setup do
    @user = {
      name: "Tramplesauce",
      email: "imagine.magics@example.com"
    }
  end

  test "cannot access dm screen" do
    visit dungeon_master_root_path
    assert_current_path guests_sign_in_path
  end
end
