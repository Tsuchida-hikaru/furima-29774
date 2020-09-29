require 'rails_helper'

RSpec.describe "Tweets", type: :request do

  before do
    @user = FactoryBot.create(:user)
  end

  describe "GET /tweets" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに出品済みの商品のテキストが存在する" do
      get root_path
      expect(response.body).to include @user.text
    end
    it "indexアクションにリクエストするとレスポンスに出品済みの商品の画像URLが存在する" do
      get root_path
      expect(response.body).to include @user.image
    end
    it "indexアクションにリクエストするとレスポンスに「出品する」ボタンが存在する" do
      get root_path
      expect(response.body).to include "出品する"
    end
  end
end
