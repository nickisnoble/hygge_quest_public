require "test_helper"

class ConfigurationTest < ActiveSupport::TestCase
  test "requires key" do
    config = Configuration.new(value: "test")
    assert_not config.valid?
    assert_includes config.errors[:key], "can't be blank"
  end

  test "requires unique key" do
    Configuration.create!(key: "test_key", value: "value1")
    config = Configuration.new(key: "test_key", value: "value2")
    assert_not config.valid?
    assert_includes config.errors[:key], "has already been taken"
  end

  test "get returns value for existing key" do
    Configuration.create!(key: "test_key", value: "test_value")
    assert_equal "test_value", Configuration.get("test_key")
  end

  test "get returns default for missing key" do
    assert_equal "default", Configuration.get("nonexistent", "default")
  end

  test "get returns nil for missing key without default" do
    assert_nil Configuration.get("nonexistent")
  end

  test "set creates new configuration" do
    assert_difference "Configuration.count", 1 do
      Configuration.set("new_key", "new_value")
    end
    assert_equal "new_value", Configuration.get("new_key")
  end

  test "set updates existing configuration" do
    Configuration.create!(key: "update_key", value: "old_value")
    assert_no_difference "Configuration.count" do
      Configuration.set("update_key", "new_value")
    end
    assert_equal "new_value", Configuration.get("update_key")
  end

  test "site_title returns default" do
    assert_equal "Wedding RSVP", Configuration.site_title
  end

  test "site_title returns custom value" do
    Configuration.set("site_title", "Our Wedding")
    assert_equal "Our Wedding", Configuration.site_title
  end

  test "couple_names returns nil by default" do
    assert_nil Configuration.couple_names
  end

  test "couple_names returns custom value" do
    Configuration.set("couple_names", "John & Jane")
    assert_equal "John & Jane", Configuration.couple_names
  end
end
