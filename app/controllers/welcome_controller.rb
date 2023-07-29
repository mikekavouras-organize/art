class WelcomeController < ApplicationController
  def index
    render "welcome/index", locals: {
      info: ArtistInfo.last,
    }
  end
end
