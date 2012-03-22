class AddMajorIdToAdmissionInformation < ActiveRecord::Migration
  def change
    add_column :admission_informations, :major_id, :integer
  end
end
