class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.belongs_to :user, index: true, null: true
      t.timestamps
    end
  end
end
