class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.date     "date"               
      t.string   "caption"
      t.text     "description"           
      t.string   :full_path_url
      t.string   :thumbnail_url
      t.string   :flickr_url
      t.string   :photo_id
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
