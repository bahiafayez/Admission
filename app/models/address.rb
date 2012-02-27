class Address < ActiveRecord::Base
  belongs_to :applicant
  
  validates :address, :email, :address_type, :presence => true
  validates_inclusion_of :address_type, :in => ["mailing", "home", "both"]
  validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Invalid E-mail"}
  validates :fax, :mobile, :telephone, :format => {:with => /^[0-9]+$/ , :message => "Invalid Number"}
  validate :a_number_present #either telephone or mobile must be present


  private
   
  def a_number_present 
    errors.add(:telephone, "can't be blank") if telephone.blank? && mobile.blank? 
    errors.add(:mobile, "can't be blank") if telephone.blank? && mobile.blank? 
  end 
#comment
end