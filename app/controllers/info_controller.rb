# frozen_string_literal: true

class InfoController < ApplicationController
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def index
    render "info/index", locals: {
      info: ArtistInfo.last,
      resume: Resume.last
    }
  end

  def cv
    resume = Resume.last
    redirect_to rails_blob_url(resume.attachment.blob)
  end
end
