class ChangeColumnNullItemId < ActiveRecord::Migration[6.0]
  def change
    change_column_null :user_items, :item_id, true
    change_column_null :line_items, :item_id, true
  end
end
