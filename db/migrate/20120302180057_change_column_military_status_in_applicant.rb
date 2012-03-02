class ChangeColumnMilitaryStatusInApplicant < ActiveRecord::Migration
  def up
    change_column :applicant, :military_status, :string , :default => "Does not apply"
  end

  def down
    change_column :applicant, :military_status, :string , :default => nil
  end
end
