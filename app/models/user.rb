class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  after_create :create_cart
  has_one :cart
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


  private

    def create_cart
      Cart.create(user_id: self.id)
    end
end
