class Order < ApplicationRecord
  after_update :send_mail, if: -> { Rails.env.production? }
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

  def as_json(options={})
    options[:methods] = [:total]
    super
  end

  def resume_order
    self.order_items.map do |oi|
      "#{oi.item.name}: x #{oi.quantity}"
    end.join('</br>').html_safe
  end

  def send_mail
    if self.status == "confirmed"
      @user_id = self.user_id
      UserMailer.order_email(self).deliver_now
    end
  end 
  
  rails_admin do
    exclude_fields :order_items
  end

end
