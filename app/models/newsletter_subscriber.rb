class NewsletterSubscriber < ApplicationRecord
  validates :email, uniqueness: true
end
