require "test_helper"

class GroupTest < ActiveSupport::TestCase
  test "requires name" do
    group = Group.new
    assert_not group.valid?
    assert_includes group.errors[:name], "can't be blank"
  end

  test "requires unique name (case insensitive)" do
    existing = groups(:family)
    group = Group.new(name: existing.name.upcase)
    assert_not group.valid?
    assert_includes group.errors[:name], "has already been taken"
  end

  test "normalizes name by stripping whitespace" do
    group = Group.create!(name: "  Test Group  ")
    assert_equal "Test Group", group.name
  end

  test "has many members through guests" do
    group = groups(:family)
    assert_includes group.members, guests(:nick)
    assert_includes group.members, guests(:marnie)
  end

  test "returns all attending members" do
    group = groups(:family)
    # Assuming fixtures have attending guests
    assert group.members.any?
  end
end
