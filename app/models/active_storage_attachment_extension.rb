# frozen_string_literal: true

module ActiveStorageAttachmentExtension
  extend ActiveSupport::Concern


  LIMIT_SIZE = [640, 640].freeze

  def title
    self[:title] || self.record.title
  end

  def description
    self[:description] || self.record.description
  end

  def preview_url
    self.preview(resize_to_limit: LIMIT_SIZE).processed.service_url
  rescue URI::InvalidURIError
    "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
  end
end
