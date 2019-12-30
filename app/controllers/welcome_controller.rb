class WelcomeController < ApplicationController
    def index
        @name = params[:name] || "person"
    end
end