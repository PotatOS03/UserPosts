require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without first name" do
    user = User.new(last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user without a first name"
  end
  test "should not save user with blank first name" do
    user = User.new(first_name: " ", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user with a blank first name"
  end
  test "should not save user without last name" do
    user = User.new(first_name: "John", email: "john@example.com", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user without a last name"
  end
  test "should not save user with blank last name" do
    user = User.new(first_name: "John", last_name: " ", email: "john@example.com", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user with a blank last name"
  end
  test "should not save user without email" do
    user = User.new(first_name: "John", last_name: "Doe", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user without an email"
  end
  test "should not save user with invalid email" do
    user = User.new(first_name: "John", last_name: "Doe", email: "invalid_email", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user with an invalid email"
  end
  test "should not save user without password" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password_confirmation: "password")
    assert_not user.save, "Saved the user without a password"
  end
  test "should not save user with password confirmation mismatch" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "mismatch")
    assert_not user.save, "Saved the user with a password confirmation mismatch"
  end
  test "should not save user with short password" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: "short", password_confirmation: "short")
    assert_not user.save, "Saved the user with a short password"
  end
  test "should save user with valid attributes" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password")
    assert user.save, "Failed to save the user with valid attributes"
  end
  test "should return full name" do
    user = User.new(first_name: "John", last_name: "Doe")
    assert_equal "John Doe", user.full_name, "Full name method did not return the expected result"
  end
  test "should strip whitespace from first and last name" do
    user = User.new(first_name: "  John  ", last_name: "  Doe  ", email: "john@example.com", password: "password", password_confirmation: "password")
    assert user.save, "Failed to save the user with valid attributes"
    user.reload # Reload the user to get the stripped attributes
    assert_equal "John", user.first_name
    assert_equal "Doe", user.last_name
  end
  test "should have many posts" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password")
    assert user.save, "Failed to save the user with valid attributes"
    post = user.posts.build(title: "Test Post", body: "This is a test post.")
    assert post.save, "Failed to save the post"
    assert_equal 1, user.posts.count, "User should have many posts"
  end
  test "should destroy associated posts when user is deleted" do
    user = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password")
    assert user.save, "Failed to save the user with valid attributes"
    post = user.posts.build(title: "Test Post", body: "This is a test post.")
    assert post.save, "Failed to save the post"
    assert_difference("Post.count", -1) do
      user.destroy
    end
    assert_not Post.exists?(post.id), "Post should be destroyed when user is deleted"
  end
  test "should not allow duplicate email" do
    user1 = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password")
    assert user1.save, "Failed to save the first user with valid attributes"
    user2 = User.new(first_name: "Jane", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password")
    assert_not user2.save, "Saved the user with a duplicate email"
  end
end
