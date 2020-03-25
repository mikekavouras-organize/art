class AddMetadataToAssets < ActiveRecord::Migration[6.0]
  def up
    add_column :active_storage_attachments, :title, :string
    add_column :active_storage_attachments, :description, :string
  end

  def down
    remove_column :active_storage_attachments, :title, :string
    remove_column :active_storage_attachments, :description, :string
  end
end
