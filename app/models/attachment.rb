class Attachment < ActiveRecord::Base
  belongs_to :applicant
  has_attached_file :personal_experience, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :additional_information, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :school_certificates, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  #validates_attachment_presence :personal_experience
  #validates_attachment_content_type :personal_experience, :content_type => ['application/pdf']
  #validates_attachment_content_type :additional_information, :content_type => ['application/pdf']
  
end
