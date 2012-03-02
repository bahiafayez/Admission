class Work < ActiveRecord::Base
  belongs_to :applicant
  
  #won't validate presence, since not necessary that applicant has work experience.. later will add option to remove work if don't have any..
  #validates :employer, :worked_from , :worked_to, :tasks, :presence => true
  validates_date :worked_from, :worked_to
  
end