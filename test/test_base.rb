class TestBase < ActionDispatch::IntegrationTest
  def as(user)
    post admin_sessions_path, params: {
      username: user.username,
      password: user.password
    }
  end
end
