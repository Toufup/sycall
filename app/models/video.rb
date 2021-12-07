class Video < ApplicationRecord
  belongs_to :lyrics_versions

  validates :url, presence: true, uniqueness: true

  enum type: { recommend: 0, official: 1 }
end
# TODO コールと動画URLの紐付けをする
# TODO 人気キーワードのテーブルを作成する
