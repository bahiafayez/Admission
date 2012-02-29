class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :gender
      t.string :military_status
      t.string :national_id
      t.date :national_id_expiry_date
      t.string :passport_number
      t.string :country_of_issuance
      t.date :passport_expiry_date
      t.text :academic_honours
      t.text :extra_activities
      t.string :transportation
      t.has_attached_file :photo

      t.timestamps
    end
  end
end
