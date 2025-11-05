require "test_helper"

class PageTest < ActiveSupport::TestCase
  test "requires title" do
    page = Page.new(slug: "test")
    assert_not page.valid?
    assert_includes page.errors[:title], "can't be blank"
  end

  test "slug is auto-generated on validation if blank" do
    page = Page.new(title: "Test Page")
    page.slug = nil
    page.valid? # triggers auto-generation
    assert_equal "test-page", page.slug
  end

  test "requires unique slug" do
    page1 = Page.create!(title: "Test", slug: "test-page")
    page2 = Page.new(title: "Test 2", slug: "test-page")
    assert_not page2.valid?
    assert_includes page2.errors[:slug], "has already been taken"
  end

  test "slug format validation" do
    page = Page.new(title: "Test", slug: "Invalid Slug!")
    assert_not page.valid?
    assert_includes page.errors[:slug], "only lowercase letters, numbers, and hyphens"
  end

  test "auto-generates slug from title if not provided" do
    page = Page.new(title: "My Test Page")
    page.valid?
    assert_equal "my-test-page", page.slug
  end

  test "uses slug as URL parameter" do
    page = Page.create!(title: "Test", slug: "test-page")
    assert_equal "test-page", page.to_param
  end

  test "published scope returns only published pages" do
    published = Page.create!(title: "Published", slug: "published", published: true)
    unpublished = Page.create!(title: "Unpublished", slug: "unpublished", published: false)

    assert_includes Page.published, published
    assert_not_includes Page.published, unpublished
  end

  test "has rich text content" do
    page = Page.create!(title: "Test", slug: "test")
    page.update(content: "Rich text content")
    assert_equal "Rich text content", page.content.to_plain_text.strip
  end
end
