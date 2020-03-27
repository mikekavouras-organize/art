class RenamePiecesToSeries < ActiveRecord::Migration[6.0]
  def change
    rename_table :pieces, :series
  end
end
