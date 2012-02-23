class SecondarySchool < ActiveRecord::Base
  belongs_to :applicant
  
  validates :name, :address, :language, :attended_from , :attended_to, :school_type, :presence => true
  validates_date :attended_from, :attended_to, :graduation_date
  validates_inclusion_of :school_type, :in => ["public", "private"]
  
  
end