class College < ActiveRecord::Base
  belongs_to :applicant
  # won't validate presence, since not for sure that applicant was in another college.
  #validates :name, :faculty, :major, :city, :country, :attended_from, :attended_to, :language, :gpa, :presence => true
  #if the student did not go to a university, then no model will not be created
  # but if he did, we must validate the presence of everything..
  validates_date :attended_from, :attended_to
  validates :gpa, :numericality => {:less_than_or_equal_to => 5}
  
end
