class CreatePieces < ActiveRecord::Migration[6.0]
  def change
    create_table :pieces do |t|
      t.string :description
      t.string :title
      t.timestamps
      t.references :category
    end
  end
end
