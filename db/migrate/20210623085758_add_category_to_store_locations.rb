class AddCategoryToStoreLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :store_locations, :category, :string
  end
end
