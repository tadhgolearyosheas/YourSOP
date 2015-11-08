class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :description
      t.boolean :enabled
      t.integer :sequence

      t.timestamps null: false
    end    
  end
end
