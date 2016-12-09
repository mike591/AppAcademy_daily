class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id
      t.string :name
      t.string :album_type

      t.timestamps null: false
    end
    add_index :albums, :band_id
    add_index :albums, :name
  end
end
