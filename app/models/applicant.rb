class Applicant < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :addresses, :dependent => :destroy
  has_one :admission_information, :dependent => :destroy
  has_many :secondary_schools, :dependent => :destroy
  has_many :colleges, :dependent => :destroy
  has_many :works, :dependent => :destroy
  has_one :attachment, :dependent => :destroy
  has_many :guardians, :dependent => :destroy
  has_many :healths, :dependent => :destroy
  has_many :uni_related_infos, :dependent => :destroy
  
  validates :first_name, :middle_name,:last_name,:date_of_birth, :place_of_birth, :gender,:military_status, :national_id, :national_id_expiry_date, :passport_number, :country_of_issuance, :passport_expiry_date, :transportation, :photo_file_name, :photo_content_size, :photo_file_size, :presence => true
  validates_date :date_of_birth, :passport_expiry_date, :national_id_expiry_date
  validates_inclusion_of :gender, :in => ["female", "male"]
  validates_inclusion_of :military_status, :in => ["completed", "exempted","postponed", "does not apply"]
  validates_inclusion_of :transportation, :in => ["private", "Nu buses"]
  #CONTINUE VALIDATION  
   
end
