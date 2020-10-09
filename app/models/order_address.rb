class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address_number, :apartment_number, :phone_number, :user_id, :product_id, :price, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: '郵便番号は○○○-○○○○のように、ハイフンを挟んだ７文字の半角数字で入力してください' }
    validates :city
    validates :address_number
    validates :apartment_number
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: '半角数字のみ使用出来ます。ハイフンは不要です' }
    validates :price, :user_id, :product_id, :token
  end
  
  validates :prefecture_id, numericality: { other_than: 1, message: '初期値以外を選択してください'}

  def save
    order = Order.create(user_id: :user_id, product_id: :product_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address_number: address_number, apartment_number: apartment_number, phone_number: phone_number, order_id: order.id)
  end
end