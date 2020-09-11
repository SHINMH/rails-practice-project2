class AddPaidAtCanceledAtIndexToOrders < ActiveRecord::Migration[6.0]
  def change
    add_index :orders, :paid_at
    add_index :orders, :canceled_at
  end
end
