class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :body
      t.integer :tag, default: 0

      t.timestamps
    end
  end
end
