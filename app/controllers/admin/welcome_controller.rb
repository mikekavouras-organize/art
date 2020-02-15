module Admin
  class WelcomeController < ApplicationController
    before_action :authenticate

    layout "admin"

    def index
      render "admin/welcome/index", locals: {
        categories: Category.all
      }
    end
  end
end


