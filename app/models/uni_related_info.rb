class UniRelatedInfo < ActiveRecord::Base
  belongs_to :applicant
  
  has_one :uni_choice
  has_one :other_choice
 
  accepts_nested_attributes_for :uni_choice, :other_choice
  
 #don't need validation here.. 
  
  
end



  