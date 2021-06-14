class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.string :status
      t.timestamps
    end
  end
end
