class AddPerformerToTenders < ActiveRecord::Migration
  def change
    add_column :tenders, :performer_id, :integer
    add_index :tenders, :performer_id
  end
end
