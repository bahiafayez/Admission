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
end
