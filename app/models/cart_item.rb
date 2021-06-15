class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  validates :quantity, numericality: {greater_than: 0, only_integer: true}
end
