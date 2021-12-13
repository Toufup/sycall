class ChangeVideoColumnNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :videos, :url, true
  end
end
