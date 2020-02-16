class Piece < ApplicationRecord
  belongs_to :category

  has_many_attached :assets

  validates :title, presence: true
  validates :description, presence: true

  def ordered_assets
    self.assets.order("position ASC")
  end
end
