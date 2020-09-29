FactoryBot.define do
  factory :user do
    nickname    { 'あア亜Ａ１！' }
    email       { Faker::Internet.free_email }
    password    { 'abc123' }
    password_confirmation { password }
    first_name            {'あア亜'}
    family_name           {'いイ居'}
    furigana_first_name   {'ナマエ'}
    furigana_family_name  {'ミョウジ'}
    birthday              {Faker::Date.birthday(min_age: 10, max_age: 85)}
  end
end
