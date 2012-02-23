class CreateUniRelatedInfos < ActiveRecord::Migration
  def change
    create_table :uni_related_infos do |t|
      t.string :hear_of_uni
      t.text :factors
      t.text :majors
      t.text :other_universities
      t.text :factors_other_universities
      t.integer :applicant_id

      t.timestamps
    end
  end
end
