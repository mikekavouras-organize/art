class AddIndexToCategoriesName < ActiveRecord::Migration[6.0]
  def change
    add_index :categories, :name
  end
end
