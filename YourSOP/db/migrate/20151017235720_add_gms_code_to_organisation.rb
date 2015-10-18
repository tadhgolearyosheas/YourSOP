class AddGmsCodeToOrganisation < ActiveRecord::Migration
  def change
  	add_column :organisations, :gms_code, :string
  end
end
