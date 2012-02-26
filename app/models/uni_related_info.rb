class UniRelatedInfo < ActiveRecord::Base
  belongs_to :applicant
 
 attr_accessor :Internet
 
 #don't need validation here.. 
  
  
end



  