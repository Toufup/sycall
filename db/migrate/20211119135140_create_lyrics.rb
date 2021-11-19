class CreateLyrics < ActiveRecord::Migration[6.0]
  def change
    create_table :lyrics do |t|
      t.references :lyrics_version, null: false, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
