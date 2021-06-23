class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  after_create :welcome_send, if: -> { Rails.env.production? }
  after_create :create_cart
  after_create :add_to_mailing_list
  has_one :cart
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  private

  def create_cart
    Cart.create(user_id: self.id)
  end

  def add_to_mailing_list
    NewsletterSubscriber.create!(email: self.email)
  end

  def full_name
   if first_name.blank? && last_name.blank?
     return "not completed"
   else
     return "#{first_name} #{last_name}"
   end
  end

end
