require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "should not save post without title" do
    post = Post.new(body: "This is a test body.", user: users(:one))
    assert_not post.save, "Saved the post without a title"
  end

  test "should not save post with blank title" do
    post = Post.new(title: " ", body: "This is a test body.", user: users(:one))
    assert_not post.save, "Saved the post with a blank title"
  end

  test "should not save post without body" do
    post = Post.new(title: "Test Title", user: users(:one))
    assert_not post.save, "Saved the post without a body"
  end

  test "should not save post with blank body" do
    post = Post.new(title: "Test Title", body: " ", user: users(:one))
    assert_not post.save, "Saved the post with a blank body"
  end

  test "should save post with valid attributes" do
    post = Post.new(title: "Valid Title", body: "This is a valid body.", user: users(:one))
    assert post.save, "Failed to save the post with valid attributes"
  end

  test "should belong to user" do
    post = Post.new(title: "Test Title", body: "This is a test body.", user: users(:one))
    assert post.save, "Failed to save the post with valid attributes"
    assert_equal users(:one), post.user, "Post should belong to the correct user"
  end
end
