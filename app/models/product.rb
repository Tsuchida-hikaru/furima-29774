class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_time

  belongs_to :user
  has_one :order
  has_one_attached :image

  validates :name, :description, :image, presence: true
  validates :price, presence: true, numericality: {
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: 'は300円から9,999,999円の範囲内の半角数字で入力してください'
  }
  validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :shipping_time_id, numericality: { other_than: 1 }
end
