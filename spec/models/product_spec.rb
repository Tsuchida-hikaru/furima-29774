require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品' do
    context '商品出品成功' do
      it '商品情報が全て入力され、プルダウンメニューの情報も初期値以外になっている' do
        expect(@product).to be_valid
      end
    end

    context '商品出品失敗' do
      it '商品画像がない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明文が空' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリー情報が初期値' do
        @product.category_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include('Category must be other than 1')
      end
      it '商品状態の情報が初期値' do
        @product.condition_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include('Condition must be other than 1')
      end
      it '配送料負担の情報が初期値' do
        @product.delivery_fee_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include('Delivery fee must be other than 1')
      end
      it '発送元地域の情報が初期値' do
        @product.prefecture_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '発送までの日数についての情報が初期値' do
        @product.shipping_time_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include('Shipping time must be other than 1')
      end
      it '価格の情報が空' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が300未満' do
        @product.price = '299'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price は300円から9,999,999円の範囲内の半角数字で入力してください')
      end
      it '価格9999999を超える' do
        @product.price = '10000000'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price は300円から9,999,999円の範囲内の半角数字で入力してください')
      end
      it '販売価格が半角数字のみではない' do
        @product.price = '３００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price は300円から9,999,999円の範囲内の半角数字で入力してください')
      end
    end
  end
end
