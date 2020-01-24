require 'test_helper'

class Admin::WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "redirects to login when not logged in" do
    get admin_root_path
    assert_redirected_to new_admin_session_path
  end
end
