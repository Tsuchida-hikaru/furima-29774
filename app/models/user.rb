class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :password, format: { with: /[0-9]+[a-zA-Z]|[a-zA-Z]+[0-9]/, message: 'is invalid. Input half-size alphabet and numeral only.' }
    validates :nickname, format: { with: /\A[ぁ-んァ-ン一-龥ａ-ｚＡ-Ｚ０-９]/, message: 'is invalid. Input full-width characters.' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input full-width characters.' }
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input full-width characters.' }
    validates :furigana_first_name, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters.' }
    validates :furigana_family_name, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters.' }
    validates :birthday, format: { with: /\A[0-9\-]+\z/, message: 'is invalid. Input half-size numerical character.' }
  end
end
