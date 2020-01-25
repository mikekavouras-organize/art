module Admin
  class WelcomeController < ApplicationController
    before_action :authenticate

    layout "admin"

    def index
      @categories = Category.all
    end
  end
end


