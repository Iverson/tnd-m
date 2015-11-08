class CreateTenderLicenses < ActiveRecord::Migration
  def change
    create_table :tender_licenses do |t|
      t.references :license, index: true, foreign_key: true
      t.references :tender, index: true, foreign_key: true
      t.integer :available
      t.string :analog

      t.timestamps null: false
    end
  end
end
