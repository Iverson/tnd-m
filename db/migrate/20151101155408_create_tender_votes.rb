class CreateTenderVotes < ActiveRecord::Migration
  def change
    create_table :tender_votes do |t|
      t.boolean :value, null: false
      t.references :user, index: true, foreign_key: true
      t.references :tender, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
