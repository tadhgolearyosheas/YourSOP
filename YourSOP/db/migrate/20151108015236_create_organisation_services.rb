class CreateOrganisationServices < ActiveRecord::Migration
  def change
    create_table :organisation_services do |t|
      t.references :organisation, index: true
      t.references :service, index: true
      t.timestamps null: false
    end
  end
end
