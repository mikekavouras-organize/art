class WelcomeController < ApplicationController
  def index
    @categories = Category.all
    render "welcome/index", locals: {
      info: ArtistInfo.last,
    }
  end
end
