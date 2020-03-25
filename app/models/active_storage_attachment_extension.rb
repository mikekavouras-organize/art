# frozen_string_literal: true

module ActiveStorageAttachmentExtension
  extend ActiveSupport::Concern

  def title
    self[:title] || self.record.title
  end
end
