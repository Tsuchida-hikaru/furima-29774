require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '商品購入' do
    context '商品購入成功時' do
      it 'Address情報が全て記入出来ていたら、orderとaddressテーブルに保存が出来ること' do
        @order_address.valid?
        expect(@order_address).to be_valid
      end
    end

    context '商品購入失敗時' do
      it '郵便番号が空' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号に全角文字が使用されている' do
        @order_address.postal_code = '１２３−４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code 郵便番号は○○○-○○○○のように、ハイフンを挟んだ７文字の半角数字で入力してください')
      end
      it '郵便番号に数字とハイフン以外の半角文字が使用されている' do
        @order_address.postal_code = 'aiu:ｱｲｳｴ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code 郵便番号は○○○-○○○○のように、ハイフンを挟んだ７文字の半角数字で入力してください')
      end
      it '郵便番号が○○○-○○○以外のフォーマット' do
        @order_address.postal_code = '１２-3４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code 郵便番号は○○○-○○○○のように、ハイフンを挟んだ７文字の半角数字で入力してください')
      end
      it '郵便番号に半角のハイフンが使用されていない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code 郵便番号は○○○-○○○○のように、ハイフンを挟んだ７文字の半角数字で入力してください')
      end
      it '都道府県が初期値' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture 初期値以外を選択してください')
      end
      it '市区町村が空' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空' do
        @order_address.address_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address number can't be blank")
      end
      it '建物名が空' do
        @order_address.apartment_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Apartment number can't be blank")
      end
      it '電話番号が空' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号に全角数字が使用されている' do
        @order_address.phone_number = '０９０12345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number 半角数字のみ使用出来ます。ハイフンは不要です')
      end
      it '電話番号に半角数字以外の文字が使用されている' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number 半角数字のみ使用出来ます。ハイフンは不要です')
      end
      it 'tokenが空' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
