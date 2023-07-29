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
    resume.attachment.url.sub(/\?.*/, '')
  rescue
    "#"
  end

  def artist_statement_url
    info.artist_statement.attachment.url.sub(/\?.*/, '')
  rescue
    "#"
  end

  def info
    ArtistInfo.last
  end
end
