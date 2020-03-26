# frozen_string_literal: true

module ActiveStorageAttachmentExtension
  extend ActiveSupport::Concern

  def title
    self[:title] || self.record.title
  end

  def description
    self[:description] || self.record.description
  end
end
