FactoryBot.define do
  factory :order_address do
    postal_code       { '123-4567' }
    prefecture_id     { 2 }
    city              { '足立区１丁目２番地' }
    address_number    { '１丁目２番地' }
    apartment_number  { '存在感のすごいビル−304' }
    phone_number      { '09012345678' }
    user_id           { '1' }
    product_id        { '2' }
    price             { '300' }
    token             { 'tok_abcdefghijk00000000000000000' }
  end
end
