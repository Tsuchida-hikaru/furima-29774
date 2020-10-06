require 'rails_helper'

RSpec.describe "Products", type: :system do
  describe '商品出品機能' do
    before do
      @product = FactoryBot.create(:product)
    end

    context 'ユーザーログイン状態且つ出品成功時' do
      it '' do
        # トップページに移動してからログイン状態にする
        sign_in(@product.user)
        # トップページに「出品する」ボタンが存在する
        expect(page).to have_content('出品する')
        # トップページに「出品する」ボタン及び「新規投稿商品」リンクが存在する
        expect(page).to have_content('新規投稿商品')
        # 商品出品ページへ移動する
        click_on('新規投稿商品')
        # 商品情報を入力する
        image_path = Rails.root.join('public/images/test_image.jpg')
        attach_file('item-image', image_path)
        fill_in 'item-name', with: @product.name
        fill_in 'item-info', with: @product.description
        select @product.category.name, from: 'item-category'
        select @product.condition.name, from: 'item-condition'
        select @product.delivery_fee.name, from: 'item-delivery-fee'
        select @product.prefecture.name, from: 'item-prefecture'
        select @product.shipping_time.name, from: 'item-shipping-time'
        fill_in 'item-price', with: @product.price
        # 「出品する」ボタンを押すと、productモデルのカウントが1上がることを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Product.count }.by(1)
        # トップページへ遷移する
        expect(current_path).to eq products_path
        # トップページに先ほど出品した商品の名前が表示されることを確認する
        expect(page).to have_content(@product.name)
        # トップページに先ほど出品した商品の画像が表示されることを確認する
        expect(page).to have_selector(".item-img")
      end
    end

    context 'ユーザーログイン状態且つ出品失敗時' do
      # トップページに移動する
      # トップページに「出品する」ボタン及び「新規投稿商品」リンクが存在する
      # 商品出品ページへ移動する
      # 商品情報を入力しない
      # 「出品する」ボタンを押すと、productモデルのカウントが1上がらないことを確認する
      # 商品出品ページから遷移していないことを確認する
    end

    context 'ユーザーログイン状態で「もどる」ボタン押下時' do
      # トップページに移動する
      # トップページに「出品する」ボタン及び「新規投稿商品」リンクが存在する
      # 商品出品ページへ移動する
      # 「もどる」ボタンを押すとトップページに遷移することを確認する
    end

    context 'ユーザー未ログイン状態' do
      # トップページに移動する
      # トップページに「出品する」ボタン及び「新規投稿商品」リンクが存在する
      # 商品出品ページへ移動しようとすると、新規会員登録画面に遷移することを確認する
    end
  end
  
  describe '' do
  end

end
