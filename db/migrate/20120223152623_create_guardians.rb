class CreateGuardians < ActiveRecord::Migration
  def change
    create_table :guardians do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.text :address
      t.string :telephone
      t.string :mobile
      t.string :occupation
      t.string :company_name
      t.string :business_telephone
      t.string :email
      t.string :fax
      t.text :business_address
      t.string :relation
      t.boolean :financial
      t.integer :applicant_id

      t.timestamps
    end
  end
end
