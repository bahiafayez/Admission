class CreateOtherChoices < ActiveRecord::Migration
  def change
    create_table :other_choices do |t|
      t.boolean :quality
      t.boolean :reputation
      t.boolean :facilities
      t.boolean :location
      t.boolean :fields_of_study
      t.string :specify_fields_of_study
      t.boolean :other
      t.string :specify_other
      t.integer :uni_related_info_id
      
      t.timestamps
    end
  end
end
