class CreatePerformers < ActiveRecord::Migration
  def change
    create_table :performers do |t|
      t.string :email, null: false
      t.string :name
      t.string :position

      t.timestamps null: false
    end
  end
end
