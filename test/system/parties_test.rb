require "application_system_test_case"

class PartiesTest < ApplicationSystemTestCase
  setup do
    @user = {
      name: "Tramplesauce",
      email: "imagine.magics@example.com"
    }
  end

  def rsvp_as(user)
    visit new_party_url

    choose("Yes, I'll be there")
    fill_in "Your name", with: user[:name]
    fill_in "Your email", with: user[:email]

    click_on "Continue"
  end

  def sign_out
    visit guests_sign_out_url
  end

  def sign_in(user_email)
    ActionMailer::Base.deliveries.clear

    visit guests_sign_in_url
    fill_in "passwordless[email]", with: user_email
    click_on "Sign in"

    assert_emails 1
    email = ActionMailer::Base.deliveries.last
    assert_not_nil email
    body = email.body.to_s
    magic_link = body[/http[s]?:\/\/[\S]+/]

    visit magic_link
  end

  test "RSVP 'yes' flow" do
    rsvp_as @user

    party = Party.find_by("name LIKE ?", "%#{@user[:name]}%")
    assert_not_nil party, "Expected to find a party but didn't."
    assert_equal 1, party.guests.count, "Expected 1 guest for the party."

    guest = party.guests.first
    assert_equal @user[:name], guest.name, "Expected the guest to have the same name as the user"

    # Guests should not see group selector
    assert_no_selector "label", text: "Group"
    assert_no_text "All Groups"

    # Select food preference (should show "Meal Selection" heading, not "Feast")
    assert_text "Meal Selection"
    assert_no_text "Feast"
    find("label", text: "Duck").click

    # Add another guest
    find_link("Add guest", text: /Add guest/).click

    within "[id*=new_guest]" do
      fill_in "Name", with: "Ms. #{@user[:name]}"
      select "Fish (Salmon)", from: "Meal"
      click_on "Add Guest"

      assert_no_selector "form"
    end

    click_on "Submit RSVP!"

    page.has_content?("Thank you")
    page.has_content?(@user[:name])
    # Guests shouldn't see group information on confirmation page
    assert_no_text "group"

    assert_equal 2, party.guests.reload.count
  end

  test "RSVP partially then get logged out then log in" do
    rsvp_as @user
    sign_out

    guest = Guest.find_by(email: @user[:email])
    assert_not_nil guest

    # RSVP with the same details
    rsvp_as @user

    # should sense that
    # 1. user exists
    # 2. they are logged out
    assert_current_path guests_sign_in_path
    sign_in guest.email

    assert_current_path onboarding_path
  end

  test "RSVP 'no' flow" do
    visit new_party_url

    choose("Sorry, I can't make it")
    fill_in "Your name", with: @user[:name]
    fill_in "Your email", with: @user[:email]

    click_on "Continue"

    party = Party.find_by("name LIKE ?", "%#{@user[:name]}%")
    assert_not_nil party, "Party should exist"
    assert_not party.rsvp, "Party should have RSVP'd false"

    page.has_content?("miss you")

    fill_in "party_notes", with: "Smell ya later!"
    click_on "Send message"

    assert_current_path party_path(party)

    page.has_content?("Thank you")
    page.has_content?("Registry")
    page.has_no_content?(@user[:name])

    visit new_party_url
    assert_current_path onboarding_path
  end

  test "deadlines" do
    rsvp_as @user
    party = Party.find_by("name LIKE ?", "%#{@user[:name]}%")

    assert_equal party.response_deadline, Date.today.end_of_month
    assert_not party.locked?

    visit party_path
    page.has_content?("Edit")
    page.has_content?("+ Add")
    page.has_content?("feel free to update until")

    # Update deadline to the past
    party.update_attribute(:response_deadline, 3.days.ago)
    assert party.locked?

    visit party_path
    page.has_no_content?("Edit")
    page.has_no_content?("+ Add")
    page.has_no_content?("feel free to update until")
  end
end
