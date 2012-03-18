class RemoveSemesterFromAdmissionInformation < ActiveRecord::Migration
  def change
    remove_column :admission_informations, :semester
  end
end
