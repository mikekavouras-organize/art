module Admin
  class WelcomeController < ApplicationController
    before_action :authenticate

    def index
      @categories = Category.all
    end
  end
end


