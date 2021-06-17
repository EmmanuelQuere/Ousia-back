class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  validates :quantity, numericality: {greater_than: 0, only_integer: true}

  def total_price
    return self.quantity*self.item.price
  end
end
