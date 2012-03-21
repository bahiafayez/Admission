class Address < ActiveRecord::Base
  belongs_to :applicant
  
  validates :address, :address_type, :presence => true
  validates_inclusion_of :address_type, :in => ["Mailing Address", "Home Address", "Both"]
  #validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Invalid E-mail"}
  validates :fax, :mobile, :telephone, :format => {:with => /^[0-9]*$/ , :message => "Invalid Number"}
  validate :a_number_present #either telephone or mobile must be present
  #validates_uniqueness_of :email, :case_sensitive => false, :message => "email has already taken"

  validates_length_of :address, :maximum => 100
  validates_length_of :fax, :maximum => 20
  validates_length_of :mobile, :maximum => 20
  validates_length_of :telephone, :maximum => 20
  private
   
  def a_number_present 
    errors.add(:telephone, "can't be blank") if telephone.blank? && mobile.blank? 
    errors.add(:mobile, "can't be blank") if telephone.blank? && mobile.blank? 
  end 
#comment
end