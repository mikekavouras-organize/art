# frozen_string_literal: true

class ArtistInfo < ApplicationRecord
  has_one_attached :headshot
end
