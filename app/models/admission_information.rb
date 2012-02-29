class AdmissionInformation < ActiveRecord::Base
  belongs_to :applicant
  
  validates :semester, :applying_to, :intended_major, :toefl_test_results, :toefl_test_date, :proficiency_test, :presence => true
  validates_date :toefl_test_date
  
end



