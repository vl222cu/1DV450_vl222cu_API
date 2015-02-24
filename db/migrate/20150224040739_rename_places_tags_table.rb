class RenamePlacesTagsTable < ActiveRecord::Migration
  def change
    rename_table :places_tags_tables, :places_tags
  end
end
