class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.string :name
      t.string :faculty
      t.string :major
      t.string :city
      t.string :country
      t.date   :attended_from
      t.date   :attended_to
      t.string :language
      t.float  :gpa
      t.integer :applicant_id

      t.timestamps
    end
  end
end
