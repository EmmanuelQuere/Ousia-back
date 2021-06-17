class Item < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many_attached :images
  validates :stock, numericality: {greater_than_or_equal_to: 0, only_integer: true}

  rails_admin do
    exclude_fields :cart_items, :order_items, :carts, :orders
  end
end
