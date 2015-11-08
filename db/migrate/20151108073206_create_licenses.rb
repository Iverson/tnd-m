class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
