class StoreLocation < ApplicationRecord
  validates :name, presence: true
  validates :lng, presence: true
  validates :lat, presence: true
end
