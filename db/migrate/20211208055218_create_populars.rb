class CreatePopulars < ActiveRecord::Migration[6.0]
  def change
    create_table :populars do |t|
      t.string :word

      t.timestamps
    end
  end
end
