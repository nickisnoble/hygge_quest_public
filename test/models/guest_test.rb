require "test_helper"

class GuestTest < ActiveSupport::TestCase
  test "requires name" do
    guest = Guest.new(party: parties(:one))
    assert_not guest.valid?
    assert_includes guest.errors[:name], "can't be blank"
  end

  test "requires unique name" do
    existing = guests(:nick)
    guest = Guest.new(name: existing.name, party: parties(:one))
    assert_not guest.valid?
    assert_includes guest.errors[:name], "has already been taken"
  end

  test "normalizes email to lowercase" do
    guest = Guest.create!(
      name: "Test User",
      email: "TEST@EXAMPLE.COM",
      party: parties(:one)
    )
    assert_equal "test@example.com", guest.email
  end

  test "validates email format" do
    guest = Guest.new(name: "Test", email: "not-an-email", party: parties(:one))
    assert_not guest.valid?
    assert_includes guest.errors[:email], "is invalid"
  end

  test "meal returns human-readable food preference" do
    guest = guests(:nick)
    guest.update(food_preference: :vegetarian)
    assert_equal "Vegetarian", guest.meal

    guest.update(food_preference: :duck)
    assert_equal "Duck", guest.meal

    guest.update(food_preference: :salmon)
    assert_equal "Salmon", guest.meal

    guest.update(food_preference: :child)
    assert_equal "Child's Meal", guest.meal
  end

  test "notify_admins sends email to all admin users" do
    assert_difference "ActionMailer::Base.deliveries.size", 1 do
      Guest.notify_admins("Test Subject", "Test Body")
    end

    email = ActionMailer::Base.deliveries.last
    assert_equal "Test Subject", email.subject
    assert_match "Test Body", email.body.to_s
  end

  test "belongs to party" do
    guest = guests(:nick)
    assert_instance_of Party, guest.party
  end

  test "can belong to a group" do
    guest = guests(:nick)
    assert_instance_of Group, guest.group
  end
end
