class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.has_attached_file :school_certificates
      t.has_attached_file :personal_experience
      t.has_attached_file :additional_information
      t.integer :applicant_id
      
      t.timestamps
    end
  end
end
