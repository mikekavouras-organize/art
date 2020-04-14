# frozen_string_literal: true

class InfoController < ApplicationController
  def index
    render "info/index", locals: {
      info: ArtistInfo.last
    }
  end
end
