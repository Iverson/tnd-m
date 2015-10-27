class AddDefaultToTenderMilestones < ActiveRecord::Migration
  def change
  	change_column_null :tenders, :milestones, false, ""
  end
end
