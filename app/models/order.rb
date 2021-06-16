class Order < ApplicationRecord
  after_create :send_mail
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  def send_mail
    @user_id = self.user_id
    UserMailer.order_email(self).deliver_now
  end 
  
end
