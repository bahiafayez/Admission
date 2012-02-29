class Guardian < ActiveRecord::Base
  belongs_to :applicant
  
  validates :first_name, :last_name, :address, :occupation, :company_name, :business_address, :relation, :financial, :presence => true
  validate :a_number_present #either telephone or mobile must be present
  validates :fax, :mobile, :telephone, :business_telephone, :format => {:with => /^[0-9]+$/ , :message => "Invalid Number"}
  validate :a_contact_present
  validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Invalid E-mail"}
  
  
  attr_accessor :relation2
  
  private
   
  def a_number_present 
    errors.add(:telephone, "can't be blank") if telephone.blank? && mobile.blank? 
    errors.add(:mobile, "can't be blank") if telephone.blank? && mobile.blank? 
  end 
  
  def a_contact_present 
    errors.add(:business_telephone, "can't be blank") if business_telephone.blank? && email.blank? 
    errors.add(:email, "can't be blank") if business_telephone.blank? && email.blank? 
  end 
  
end
    