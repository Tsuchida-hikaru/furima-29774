class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :address

  validates :user, :product, :address, presence: true
end
