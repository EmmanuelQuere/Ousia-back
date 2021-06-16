class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  validates :quantity, numericality: {greater_than: 0, only_integer: true}

  def total_price
    return self.quantity*self.item.price
  end
end


