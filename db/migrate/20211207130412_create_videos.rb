class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :url, null: false
      t.integer :tag, null: false
      t.references :lyrics_version, null: false, foreign_key: true

      t.timestamps
    end
  end
end
