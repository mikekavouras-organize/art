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

  # Use Active Storage's redirect URL rather than the raw storage URL with the
  # signature stripped — the latter only worked because S3 objects were
  # public-read. R2 objects are private, so they need the signed redirect.
  def resume_url
    rails_blob_url(Resume.last.attachment.blob)
  rescue
    "#"
  end

  def artist_statement_url
    rails_blob_url(info.artist_statement.attachment.blob)
  rescue
    "#"
  end

  def info
    ArtistInfo.last
  end
end
