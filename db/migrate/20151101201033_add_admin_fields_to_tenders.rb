class AddAdminFieldsToTenders < ActiveRecord::Migration
  def change
    add_column :tenders, :important, :boolean, null: false, default: false
    add_column :tenders, :necessary, :boolean, null: false, default: false
  end
end
