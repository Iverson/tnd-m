class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :name, null: false
      t.references :tender, index: true, foreign_key: true
      t.references :performer, index: true, foreign_key: true
      t.date :estimate_date
      t.date :tender_date
      t.date :complete_date

      t.timestamps null: false
    end

    reversible do |change|
      change.up do
        Tender.where.not(performer_id: nil).each do |tender|
          tender.milestones.create(name: "PRE-SALE", performer_id: tender.performer_id)
        end
      end

      change.down do
        Milestone.delete_all
      end
    end
  end
end
