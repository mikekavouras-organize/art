class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.integer :category_id

      t.timestamps
    end
  end
end
