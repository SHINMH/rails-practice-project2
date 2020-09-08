class ChangeColumnNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :category_id, true
  end
end
