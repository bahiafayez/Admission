class AddSemesterIdToAdmissionInformation < ActiveRecord::Migration
  def change
    add_column :admission_informations, :semester_id, :integer
  end
end
