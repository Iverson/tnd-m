class AddLeadTimeToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :lead_time, :string
    add_column :milestones, :code, :string

    add_index :milestones, :code
  end
end
