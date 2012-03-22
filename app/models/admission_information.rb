class AdmissionInformation < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :program
  belongs_to :semester
  belongs_to :major
  
  validates :semester_id, :program_id, :major_id, :toefl_test_results, :toefl_test_date, :presence => true
  validates_date :toefl_test_date
<<<<<<< HEAD
  #validates :intended_major, :format => {:with => /^[a-zA-Z\s]+$/, :message => "intended_major contains non alphabetical characters"}
=======
  validates :intended_major, :format => {:with => /^[a-zA-Z\s]+$/, :message => "intended_major contains non alphabets"}
>>>>>>> baee77680c4e0d5a9fef570c767026a167d0aa36
  validates :toefl_test_results, :format => {:with => /^[0-9]*$/ , :message => "Invalid Number"}
  
end



