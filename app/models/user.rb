class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_one :cart
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def full_name
   if first_name.blank? && last_name.blank?
     return "not completed"
   else
     return "#{first_name} #{last_name}"
   end
  end
end
