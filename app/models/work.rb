class Work < ActiveRecord::Base
  belongs_to :applicant
  
  #won't validate presence, since not necessary that applicant has work experience.. later will add option to remove work if don't have any..
  validates :employer, :worked_from , :worked_to, :tasks, :presence => true
  validates_date :worked_from, :worked_to
  validates_length_of :employer, :maximum => 30
  validates_length_of :tasks, :maximum => 500
  
  validate :attended_validate

  def attended_validate
    errors.add(:worked_from, "Please choose a date before 'attended to' date") if worked_from && worked_to && worked_from > worked_to
  end
  
end