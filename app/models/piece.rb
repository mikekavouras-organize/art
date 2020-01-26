class Piece < ApplicationRecord
  belongs_to :category

  has_many_attached :assets

  def update_media_positions(ordered_ids = [])
    if ordered_ids.empty?
      set_initial_positions
    else
      update_positions(ordered_ids)
    end
  end

  def set_initial_positions
    existing_assets, new_assets = assets.partition(&:persisted?)
    highest_current_position = existing_assets.count
    new_assets.each_with_index do |new_asset, index|
      new_asset.position = highest_current_position + index
    end
  end

  def update_positions(ordered_ids)
    ordered_ids.each_with_index do |id, index|
      asset = assets.find { |asset| asset.id == id.to_i }
      asset.position = index
      asset.save
    end
  end
end
