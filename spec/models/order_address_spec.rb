require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '商品購入' do
    context '商品購入成功時' do
      it "Address情報が全て記入出来ていたら、orderとaddressテーブルに保存が出来ること"
        expect(@).to be_valid
      end
    end

    context '商品購入失敗時' do
      it '郵便番号が空' do
        expect().to
      end
      it '都道府県が初期値' do
        expect().to
      end
      it '市区町村が空' do
        expect().to
      end
      it '番地が空' do
        expect().to
      end
      it '建物名が空' do
        expect().to
      end
      it '電話番号が空' do
        expect().to
      end
  end

  
end
