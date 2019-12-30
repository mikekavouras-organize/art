require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "only allows whitelisted usernames" do
    User::WHITELISTED_USERNAMES.each do |username|
      valid_user = build(:valid_user, username: username)
      assert valid_user.valid?
    end

    invalid_user = build(:invalid_user)
    refute invalid_user.valid?
  end

  test "validates uniqueness of username" do
    user = create(:valid_user)
    user2 = build(:user, username: user.username)
    refute user2.valid?
    assert_includes user2.errors.messages[:username], "has already been taken"
  end
end
