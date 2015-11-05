class RenameMilstoneColumnForTenders < ActiveRecord::Migration
  def change
    rename_column :tenders, :milestones, :tender_milestones
  end
end
