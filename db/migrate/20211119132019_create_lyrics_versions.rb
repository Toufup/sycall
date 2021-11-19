class CreateLyricsVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :lyrics_versions do |t|
      t.string :source, null: false
      t.references :song, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
