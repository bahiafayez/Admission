class Health < ActiveRecord::Base
  belongs_to :applicant
  
  validates :illness, :presence => true
end


