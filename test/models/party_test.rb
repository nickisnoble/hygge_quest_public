require "test_helper"

class PartyTest < ActiveSupport::TestCase
  test "has many guests" do
    party = parties(:one)
    assert_includes party.guests, guests(:nick)
    assert_includes party.guests, guests(:marnie)
  end

  test "accepts nested attributes for guests" do
    party = Party.new(
      rsvp: true,
      guests_attributes: [
        { name: "Test Guest", email: "test@example.com" }
      ]
    )
    assert party.save
    assert_equal 1, party.guests.count
    assert_equal "Test Guest", party.guests.first.name
  end

  test "auto-generates name from first guest if not provided" do
    party = Party.new(rsvp: true)
    party.guests.build(name: "Test Guest", email: "test@example.com")
    party.save!
    assert_match /Test Guest.s Party/, party.name
  end

  test "locked? returns true if response_deadline is in the past" do
    party = parties(:one)
    party.update(response_deadline: 1.day.ago)
    assert party.locked?
  end

  test "locked? returns false if response_deadline is in the future" do
    party = parties(:one)
    party.update(response_deadline: 1.day.from_now)
    assert_not party.locked?
  end

  test "locked? returns false if response_deadline is nil" do
    party = parties(:one)
    party.update(response_deadline: nil)
    assert_not party.locked?
  end
end
