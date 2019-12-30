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
end
