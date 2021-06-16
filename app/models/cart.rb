class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  def total
    sum = 0
    self.cart_items.each do |cart_item|
      sum += cart_item.total_price
    end
    return sum
  end
end


