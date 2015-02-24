class CreatePlacesTagsTable < ActiveRecord::Migration
  def change
    create_table :places_tags_tables, :id => false do |t|
      t.integer "place_id"
      t.integer "tag_id"
    end
    
    add_index :places_tags_tables, ["place_id", "tag_id"]
  end
end
