FactoryBot.define do
  factory :product do
    name              { 'あア亜Ａ１！' }
    description       { '商品説明\nｼｮｳﾋﾝｾﾂﾒｲ\ndescription' }
    category_id       { 2}
    condition_id      {2}
    delivery_fee_id   {2}
    prefecture_id     {2}
    shipping_time_id  {2}
    price             {'300'}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg', content_type: 'image/jpg')
    end

    user
  end
end
