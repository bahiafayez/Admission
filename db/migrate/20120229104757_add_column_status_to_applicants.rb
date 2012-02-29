class AddColumnStatusToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :status, :string, :default => "Just Created"
  end
end
