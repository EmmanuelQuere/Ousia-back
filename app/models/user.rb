class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  after_create :welcome_send


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
        
end
