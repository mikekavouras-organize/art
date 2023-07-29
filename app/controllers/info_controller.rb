# frozen_string_literal: true

class InfoController < ApplicationController
  def index
    render "info/index", locals: {
      info: info,
      resume_url: resume_url,
      artist_statement_url: artist_statement_url,
    }
  end

  def cv
    resume = Resume.last
    redirect_to rails_blob_url(resume.attachment.blob)
  end

  def artist_statement
    redirect_to rails_blob_url(info.artist_statement.attachment.blob)
  end

  def resume_url
    return unless url = resume.attachment.url rescue "#"
    url.sub(/\?.*/, '')
  end

  def artist_statement_url
    return unless url = info.artist_statement.attachment.url rescue "#"
    url.sub(/\?.*/, '')
  end

  def info
    ArtistInfo.last
  end
end
