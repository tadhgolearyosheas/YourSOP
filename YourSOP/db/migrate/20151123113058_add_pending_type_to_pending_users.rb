class AddPendingTypeToPendingUsers < ActiveRecord::Migration
  def change
  	add_column :pending_users, :pending_type, :integer
  end
end
