class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  rails_admin do
    exclude_fields :order_items
  end
end
