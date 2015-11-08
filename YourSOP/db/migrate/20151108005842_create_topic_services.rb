class CreateTopicServices < ActiveRecord::Migration
  def change
    create_table :topic_services do |t|
      t.references :topic, index: true
      t.references :service, index: true
      t.timestamps null: false
    end
  end
end
