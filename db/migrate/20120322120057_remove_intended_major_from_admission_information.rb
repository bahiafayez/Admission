class RemoveIntendedMajorFromAdmissionInformation < ActiveRecord::Migration
  def change
    remove_column :admission_informations, :intended_major
  end
end
