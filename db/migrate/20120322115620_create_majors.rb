class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
      t.boolean :status
      t.integer :program_id

      t.timestamps
    end
  end
end
