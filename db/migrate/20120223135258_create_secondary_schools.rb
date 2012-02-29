class CreateSecondarySchools < ActiveRecord::Migration
  def change
    create_table :secondary_schools do |t|
      t.string :name
      t.text :address
      t.string :language
      t.date :attended_from
      t.date :attended_to
      t.string :certificate_type
      t.date :graduation_date
      t.string :division
      t.string :school_type
      t.integer :applicant_id

      t.timestamps
    end
  end
end
