class CreateAdmissionInformations < ActiveRecord::Migration
  def change
    create_table :admission_informations do |t|
      t.string :semester
      t.string :applying_to
      t.string :intended_major
      t.float :toefl_test_results
      t.date :toefl_test_date
      t.boolean :proficiency_test
      t.integer :applicant_id

      t.timestamps
    end
  end
end
