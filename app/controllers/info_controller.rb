# frozen_string_literal: true

class InfoController < ApplicationController
  def index
    render "info/index", locals: {
      info: ArtistInfo.last
    }
  end

  def cv
    resume = Resume.last
    redirect_to rails_blob_url(resume.attachment.blob)
  end
end
