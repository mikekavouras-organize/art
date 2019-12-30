class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
    test "redirects to admin root when authenticated" do
      User.create(username: "bennfos", password: "password")
      post admin_sessions_path, params: {username: "bennfos", password: "password"}
      assert_redirected_to admin_root_path
    end
  end