module Admin
  class SessionsController < ::AdminController
    skip_before_action :authenticate

    layout "admin"

    def new
    end

    def create
      user = User.find_by(username: create_params[:username])
      if user && user.authenticate(create_params[:password])
         session[:user_id] = user.id
         redirect_to admin_root_path
      else
         redirect_to new_admin_session_path
      end
    end

    private

    def create_params
      params.permit(:username, :password)
    end
  end
end
