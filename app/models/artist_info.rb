# frozen_string_literal: true

class ArtistInfo < ApplicationRecord
  has_one_attached :headshot
  has_one_attached :artist_statement
end
