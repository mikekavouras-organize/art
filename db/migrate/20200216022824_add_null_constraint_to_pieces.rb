class AddNullConstraintToPieces < ActiveRecord::Migration[6.0]
  def change
    remove_column :pieces, :title, :string
    remove_column :pieces, :description, :string
    remove_column :pieces, :category_id, :bigint
    add_column :pieces, :title, :string, null: false
    add_column :pieces, :description, :string, null: false
    add_column :pieces, :category_id, :bigint, null: false

    remove_column :categories, :name, :string
    remove_column :categories, :slug, :string
    add_column :categories, :name, :string, null: false
    add_column :categories, :slug, :string, null: false
  end
end
