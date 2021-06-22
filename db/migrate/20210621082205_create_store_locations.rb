class CreateStoreLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :store_locations do |t|
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.timestamps
    end
  end
end
