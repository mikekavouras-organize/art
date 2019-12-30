module Admin
  class WelcomeController < ApplicationController
    def index
      unless logged_in?
        return redirect_to new_admin_session_path
      end
    end
  end
end


