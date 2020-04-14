class CreateArtistInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :artist_infos do |t|
      t.string :bio

      t.timestamps
    end
  end
end
