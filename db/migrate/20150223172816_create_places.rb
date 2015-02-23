class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.belongs_to :creator, index: true
      t.string :name
      t.text :text
      t.timestamps null: false
    end
  end
end
