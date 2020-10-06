require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before do
    @product = FactoryBot.create(:product)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに出品済み商品の名前が存在する' do
      get root_path
      expect(response.body).to include @product.name
    end
    it 'indexアクションにリクエストするとレスポンスに出品済み商品の画像URLが存在する' do
      get root_path
      expect(response.body).to include @product.image
    end
    it 'indexアクションにリクエストするとレスポンスに「出品する」ボタンが存在する' do
      get root_path
      expect(response.body).to include '出品する'
    end
  end
end
