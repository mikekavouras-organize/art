# frozen_string_literal: true

class Series < ApplicationRecord
  belongs_to :category

  has_many_attached :assets

  validates :title, presence: true

  def ordered_assets
    self.assets.order("position ASC")
  end
end
