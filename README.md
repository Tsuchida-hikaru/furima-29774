# テーブル設計
## users テーブル
| Column   | Type       | Options     |
| -------- | ------     | ----------- |
| first_name  | string     | null: false |
| family_name | string     | null: false |
| furigana_first_name  | string     | null: false |
| furigana_family_name | string     | null: false |
| email    | string     | null: false |
| password | string     | null: false |
| nickname | string     | null: false |
| birthday | date       | null: false |
- アソシエーション
  - has_many :products
  - has_many :comments
  - has_one  :purchase

## products テーブル
| Column             | Type      | Options     |
| ------             | ------    | ----------- |
| name               | string    | null: false |
| description        | text      | null: false |
| price              | integer   | null: false |
| category_id        | integer   | null: false |
| condition_id       | integer   | null: false |
| delivery_fee_id    | integer   | null: false |
| prefecture_id      | integer   | null: false |
| shipping_time_id   | integer   | null: false |
| user               | references | null: false, foreign_key: true |
- アソシエーション
  - belongs_to :user
  - has_many :comments
  - has_one :purchase

- アクティブハッシュ
  - category
    - '---'
    - レディース
    - メンズ
    - ベビー・キッズ
    - インテリア・住まい・小物
    - 本・音楽・ゲーム
    - おもちゃ・ホビー・グッズ
    - 家電・スマホ・カメラ
    - スポーツ・レジャー
    - ハンドメイド
    - その他

  - condition
    - '---'
    - 新品、未使用
    - 未使用に近い
    - 目立った傷や汚れなし
    - やや傷や汚れなし
    - 傷や汚れあり
    - 全体的に状態が悪い

  - delivery_fee
    - '---'
    - 着払い（購入者負担）
    - 送料込み（出品者負担）
  
  - prefecture
    - '---'
    - 北海道
    - 青森県
    - 岩手県
    - 宮城県
    - 秋田県
    - 山形県
    - 福島県
    - 茨城県
    - 栃木県
    - 群馬県
    - 埼玉県
    - 千葉県
    - 東京都
    - 神奈川県
    - 新潟県
    - 富山県
    - 石川県
    - 福井県
    - 山梨県
    - 長野県
    - 岐阜県
    - 静岡県
    - 愛知県
    - 三重県
    - 滋賀県
    - 京都府
    - 大阪府
    - 兵庫県
    - 奈良県
    - 和歌山県
    - 鳥取県
    - 島根県
    - 岡山県
    - 広島県
    - 山口県
    - 徳島県
    - 香川県
    - 愛媛県
    - 高知県
    - 福岡県
    - 佐賀県
    - 長崎県
    - 熊本県
    - 大分県
    - 宮崎県
    - 鹿児島県
    - 沖縄県

  - shipping-time
    - '---'
    - 1~2日で発送
    - 2~3日で発送
    - 4~7日で発送

```
## コメント機能を実装する際に使用
## comments テーブル
| Column  | Type     | Options                        |
| ------- | -------- | ------------------------------ |
| comment | text     |                                |
| user    | references | null: false, foreign_key: true |
| product | references | null: false, foreign_key: true |
- アソシエーション
  - belongs_to :user
  - belongs_to :comment
```

## purchase テーブル
| Column   | Type     | Options                        |
| -------  | -------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| product  | references | null: false, foreign_key: true |
- アソシエーション
  - belongs_to :user
  - belongs_to :product
  - has_one :address

## address テーブル
| Column   | Type     | Options                        |
| -------  | -------- | ------------------------------ |
| postal_code | string | null: false |
| prefecture_id | integer | null: false|
| city | string | null: false |
| address_number | string | null: false |
| apartment_number | string |  |
| phone_number | string | null: false |
| purchase    | references | null: false, foreign_key: true |
- アソシエーション
  - belongs_to :purchase

## Ruby version
2.6.5

## rails version
6.0.3.3