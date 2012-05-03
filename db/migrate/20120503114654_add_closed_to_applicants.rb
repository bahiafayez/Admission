class AddClosedToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :closed, :boolean, :default => 0
  end
end
