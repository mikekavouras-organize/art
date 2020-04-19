class AddPositionToSeries < ActiveRecord::Migration[6.0]
  def change
    add_column :series, :position, :integer
  end
end
