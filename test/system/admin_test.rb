require "application_system_test_case"

class AdminTest < ApplicationSystemTestCase
  setup do
    @admin_guest = guests(:admin)
    @party = parties(:nick_party)
    @guest = guests(:nick)
    @group = groups(:blue)
  end

  def sign_in_admin
    ActionMailer::Base.deliveries.clear

    visit guests_sign_in_url
    fill_in "passwordless[email]", with: @admin_guest.email
    click_on "Sign in"

    assert_emails 1
    email = ActionMailer::Base.deliveries.last
    assert_not_nil email
    body = email.body.to_s
    magic_link = body[/http[s]?:\/\/[\S]+/]

    visit magic_link
  end

  test "cannot access admin screen without auth" do
    visit admin_root_path
    assert_current_path guests_sign_in_path
  end

  test "admin can view guest list with correct columns" do
    sign_in_admin

    visit admin_root_path

    # Should see correct column headers (not fantasy names)
    assert_text "Name"
    assert_text "Party"
    assert_text "Meal"
    assert_text "Group"
    assert_no_text "Feast"
    assert_no_text "Guild"

    # Should see guest data
    assert_text @guest.name
    assert_text @guest.party.name
  end

  test "admin can edit guest and see group selector" do
    sign_in_admin

    visit admin_root_path

    # Find and click edit for our guest
    within "tr", text: @guest.name do
      click_on "Edit"
    end

    # Should see group selector (admins only)
    assert_selector "label", text: "Group"
    assert_selector "select#guest_group_id"

    # Can change group
    select @group.name, from: "guest_group_id"

    click_on "Update Guest"

    # Verify the change
    @guest.reload
    assert_equal @group.id, @guest.group_id
  end

  test "admin can manage groups" do
    sign_in_admin

    visit admin_groups_path

    assert_text "Groups"

    # Should see existing groups
    assert_text @group.name

    # Can create new group
    click_on "New Group"

    fill_in "Name", with: "Test Group"
    fill_in "Description", with: "A test group"

    click_on "Create Group"

    assert_text "Group was successfully created"
    assert Group.exists?(name: "Test Group")
  end

  test "admin can view guest meal statistics" do
    sign_in_admin

    visit admin_root_path

    # Should see meal stats (not "Feast")
    assert_text "Meal"
    assert_no_text "Feast"
    assert_text "Count"
  end

  test "admin panel uses highlight color for primary buttons" do
    sign_in_admin

    visit admin_root_path

    # Check that CSS variables are present in the page
    assert page.has_css?('style', text: '--color-highlight', visible: false)
  end
end
