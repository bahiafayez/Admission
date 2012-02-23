class CreateHealths < ActiveRecord::Migration
  def change
    create_table :healths do |t|
      t.string :illness
      t.text :description
      t.integer :applicant_id

      t.timestamps
    end
  end
end
