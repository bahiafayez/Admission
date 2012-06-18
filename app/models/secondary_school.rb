class SecondarySchool < ActiveRecord::Base
  belongs_to :applicant
  
  validates :name, :address, :certificate_type, :language, :attended_from , :attended_to, :school_type,:graduation_date, :presence => true
  validates_date :attended_from, :attended_to, :graduation_date
  validates_inclusion_of :school_type, :in => ["Public", "Private"]
  validates_length_of :address, :maximum => 100
  validates_length_of :name, :maximum => 20
  validates_inclusion_of :certificate_type, :in => ["IG", "American Diploma", "GCSE", "Thanaweya Amma"]
  validates_inclusion_of :language, :in => ["Arabic", "English", "French", "German"]
  validate :attended_validate

def attended_validate
errors.add(:attended_from, "Please choose a date before 'attended to' date") if attended_from && attended_to && attended_from > attended_to
errors.add(:graduation_date, "Please choose a date after 'attended from' date") if attended_from && graduation_date && graduation_date < attended_from
end
end