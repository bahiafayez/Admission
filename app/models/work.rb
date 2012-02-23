class Work < ActiveRecord::Base
  belongs_to :applicant
  
  validates :employer, :worked_from , :worked_to, :tasks, :presence => true
  validates_date :worked_from, :worked_to
  
end