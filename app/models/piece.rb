class Piece < ApplicationRecord
  belongs_to :category, dependent: :destroy

  has_many_attached :assets

  def ordered_assets
    self.assets.order("position ASC")
  end
end
