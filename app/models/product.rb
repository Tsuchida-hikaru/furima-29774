class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_time

  validates :name, :description, :price, presence:true
  validates :category, :condition, :delivery_fee, :prefecture, :shipping_time, numericality: { other_than: 1 }

end
