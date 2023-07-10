class ApplicationController < ActionController::Base
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?

  def authenticate
    unless logged_in?
      redirect_to new_admin_session_path
    end
  end
end
