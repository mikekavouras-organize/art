# frozen_string_literal: true

module ActiveStorageAttachmentExtension
  extend ActiveSupport::Concern

  included do
    after_create :process_video_preview
  end

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

  def process_video_preview
    return unless self.video?

    ProcessVideoPreviewJob
      .set(wait: 5.seconds)
      .perform_later(self)
  end
end
