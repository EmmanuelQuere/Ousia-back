class AddStripeidToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :stripe_id, :string
  end
end
