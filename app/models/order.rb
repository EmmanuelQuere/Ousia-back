class Order < ApplicationRecord
  after_create :send_mail
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  def total
    sum = 0
    self.order_items.each do |order_item|
      sum += order_item.total_price
    end
    return sum
  end

  def resume_order
    self.order_items.map do |oi|
      "#{oi.item.name}: x #{oi.quantity}"
    end.join('</br>').html_safe
  end

  def send_mail
    @user_id = self.user_id
    UserMailer.order_email(self).deliver_now
  end 
  
  rails_admin do
    exclude_fields :order_items
  end

end
