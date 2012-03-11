class AddProgramIdToApplicant < ActiveRecord::Migration
  def change
    add_column :admission_informations, :program_id, :integer
  end
end
