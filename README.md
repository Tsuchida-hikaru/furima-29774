# テーブル設計
## users テーブル
| Column   | Type       | Options     |
| -------- | ------     | ----------- |
| user_name| string     | null: false |
| email    | string     | null: false |
| password | string     | null: false |
| nickname | string     | null: false |
| birthday | date       | null: false |
| product_id  | references | null: false, foreign_key: true |
| comment_id  | references | null: false, foreign_key: true |

## products テーブル
| Column             | Type       | Options     |
| ------             | ------     | ----------- |
| name               | string     | null: false |
| description        | text       | null: false |
| price              | integer    | null: false |
| category           | string     | null: false |
| condition          | string     | null: false |
| delivery_fee       | integer    | null: false |
| ship-from_location | string     | null: false |
| sold               | boolean    | null: false |
| user_id               | references | null: false, foreign_key: true |
| comment_id            | references | null: false, foreign_key: true |

## comments テーブル
| Column  | Type     | Options                        |
| ------- | -------- | ------------------------------ |
| comment | text     |                                |
| user_id    | references | null: false, foreign_key: true |
| room_id    | references | null: false, foreign_key: true |