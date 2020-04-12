# frozen_string_literal: true

class ProcessVideoPreviewJob < ApplicationJob
  def perform(video)
    video
      .preview(resize_to_limit: ActiveStorage::Attachment::LIMIT_SIZE)
      .processed
  end
end
