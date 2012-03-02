class AddColumnsToApplicant < ActiveRecord::Migration
  def change
      add_column :applicants, :checkSecondary, :boolean
      add_column :applicants, :checkCollege, :boolean
      add_column :applicants, :checkWork, :boolean
      
  end
end
