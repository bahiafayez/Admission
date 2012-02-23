class Attachment < ActiveRecord::Base
  belongs_to :applicant
  has_attached_file :personal_experience, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :additional_information, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
