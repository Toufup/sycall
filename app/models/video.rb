class Video < ApplicationRecord
  belongs_to :lyrics_version

  validates :url, presence: true

  enum tag: { recommend: 0, guide: 1 }
end
# TODO コールと動画URLの紐付けをする
# TODO 人気キーワードのテーブルを作成する
