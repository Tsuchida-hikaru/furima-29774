class Address < ApplicationRecord
  belongs_to :order

  with_options presence: true do
    validates :postal_code format: { with: /\A\d{3}[-]\d{4}\z/, message: '郵便番号は○○○-○○○○のように、ハイフンを挟んだ７文字の半角数字で入力してください' }
    validates :postal_code format: { other_than: 1,message: '初期値以外を選択してください' }
    validates :city
    validates :address_number
    validates :apartment_number
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: '半角数字のみ使用出来ます。ハイフンは不要です' }
    validates :order
  end
end
