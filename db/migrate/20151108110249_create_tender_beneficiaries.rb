class CreateTenderBeneficiaries < ActiveRecord::Migration
  def change
    create_table :tender_beneficiaries do |t|
      t.references :tender, index: true, foreign_key: true
      t.boolean :disclosed
      t.text :comment

      t.timestamps null: false
    end
  end
end
