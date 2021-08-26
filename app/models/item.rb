class Item < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many_attached :images
  validates :name, presence: true, length: { in: 3..50 }
  validates :description, presence: true, length: { maximum: 2000 }
  validates :price, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 1000}
  validates :stock, numericality: {greater_than_or_equal_to: 0, only_integer: true}

  rails_admin do
    exclude_fields :cart_items, :order_items, :carts, :orders
  end
end
