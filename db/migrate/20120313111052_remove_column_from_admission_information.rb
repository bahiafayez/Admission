class RemoveColumnFromAdmissionInformation < ActiveRecord::Migration
  def change
    remove_column :admission_informations, :applying_to
  end
end
