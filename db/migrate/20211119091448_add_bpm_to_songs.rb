class AddBpmToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :bpm, :integer
  end
end
