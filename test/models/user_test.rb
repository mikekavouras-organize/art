require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "only allows whitelisted usernames" do
    User::WHITELISTED_USERNAMES.each do |username|
      valid_user = User.new(username: username, password: "password")
      assert valid_user.valid?
    end

    invalid_user = User.new(username: "bad_username", password: "password")
    refute invalid_user.valid?
  end

  test "validates uniqueness of username" do
    username = User::WHITELISTED_USERNAMES.first
    User.create(username: username, password: "password")
    user2 = User.new(username: username, password: "password")
    refute user2.valid?
    assert_includes user2.errors.messages[:username], "has already been taken"
  end
end
