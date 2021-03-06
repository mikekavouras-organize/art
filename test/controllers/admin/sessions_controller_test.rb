require 'test_helper'

class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "redirects to admin root when authenticated" do
    user = create(:valid_user)
    post admin_sessions_path, params: 
      { username: user.username, password: "password" }
    assert_redirected_to admin_root_path
  end
end
