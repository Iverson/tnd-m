class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.string :name
      t.integer :seldon_id
      t.string :customer
      t.text :milestones
      t.string :url
      t.date :start_date
      t.date :end_date
      t.float :start_max_price
      t.date :docs_deadline
      t.date :approve_deadline
      t.date :completion_date

      t.timestamps null: false
    end
  end
end
