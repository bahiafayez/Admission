class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :employer
      t.date :worked_from
      t.date :worked_to
      t.string :tasks
      t.integer :applicant_id

      t.timestamps
    end
  end
end
