class CreateUniChoices < ActiveRecord::Migration
  def change
    create_table :uni_choices do |t|
      t.boolean :internet
      t.boolean :email
      t.boolean :radio
      t.boolean :school_visits
      t.boolean :nile_university_faculty_and_staff
      t.boolean :nile_university_student_and_alumni
      t.boolean :print_advertisements
      t.string :specify_print_advertisements
      t.boolean :nu_seminar_workshop_and_conference
      t.string :specify_nu_seminar
      t.boolean :other
      t.string :specify_other
      t.integer :uni_related_info_id

      t.timestamps
    end
  end
end
