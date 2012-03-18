class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end
