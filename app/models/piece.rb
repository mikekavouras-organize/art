class Piece < ApplicationRecord
  belongs_to :category

  has_many_attached :assets
end
