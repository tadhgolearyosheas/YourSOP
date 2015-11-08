class CreateSops < ActiveRecord::Migration
  def change
    create_table :sops do |t|
		t.string :title
		t.references :services, index: true
		t.string :content
		t.string :doc_file_name
		t.string :doc_content_type
		t.integer :doc_file_size
		t.datetime :doc_updated_at
		t.string   :major_version
		t.string   :minor_version
		t.timestamps null: false
    end

  end
end
