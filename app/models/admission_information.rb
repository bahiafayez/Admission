class AdmissionInformation < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :school
  belongs_to :semester
  belongs_to :major
  
  validates :semester_id, :school_id, :toefl_test_results, :toefl_test_date, :presence => true #:major_id
  validates_date :toefl_test_date

  #validates :intended_major, :format => {:with => /^[a-zA-Z\s]+$/, :message => "intended_major contains non alphabetical characters"}

  #validates :toefl_test_results, :format => {:with => /^[0-9]*$/ , :message => "Invalid Number"}
  validates :toefl_test_results, :numericality => true
  
end



