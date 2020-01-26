class AddMediaPositionsToPieces < ActiveRecord::Migration[6.0]
  def change
    add_column :pieces, :media_positions, :integer, array: true, default: []
  end
end
