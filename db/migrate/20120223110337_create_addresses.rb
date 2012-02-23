class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :address
      t.string :telephone
      t.string :mobile
      t.string :fax
      t.string :email
      t.string :address_type
      t.integer :applicant_id

      t.timestamps
    end
  end
end
