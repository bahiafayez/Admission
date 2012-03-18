class AdmissionInformation < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :program
  belongs_to :semester
  
  validates :semester_id, :program_id, :intended_major, :toefl_test_results, :toefl_test_date, :presence => true
  validates_date :toefl_test_date
  
end



