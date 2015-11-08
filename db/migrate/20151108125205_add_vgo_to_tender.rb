class AddVgoToTender < ActiveRecord::Migration
  def change
    add_column :tenders, :is_vgo, :boolean
  end
end
