#Omnia Commenting to test git
class Applicant < ActiveRecord::Base
  belongs_to :user
  
  
  has_attached_file :photo,  :styles => {:original=>"500x500>" ,:medium => "300x300>", :thumb => "100x100>" }

  has_many :addresses, :dependent => :destroy, :order => "id ASC"
  has_one :admission_information, :dependent => :destroy
  has_many :secondary_schools, :dependent => :destroy, :order => "id ASC"
  has_many :colleges, :dependent => :destroy, :order => "id ASC"
  has_many :works, :dependent => :destroy, :order => "id ASC"
  has_one :attachment, :dependent => :destroy
  has_many :guardians, :dependent => :destroy, :order => "id ASC"
  has_many :healths, :dependent => :destroy, :order => "id ASC"
  has_one :uni_related_info, :dependent => :destroy
  
  before_validation :atleast_one
  validates :first_name, :middle_name,:last_name,:date_of_birth, :place_of_birth, :gender,:military_status, :transportation, :presence => true
  validates :first_name, :format => {:with => /^[a-zA-Z]+$/, :message => "first name contains non alphabetical characters"}
  validates :middle_name,  :format => {:with => /^[a-zA-Z]+$/, :message => "middle name contains non alphabetical characters"}
  validates :last_name, :format => {:with => /^[a-zA-Z]+$/, :message => "last name contains non alphabetical characters"}
  validates :place_of_birth, :format => {:with => /^\w+[^\d]\,\s*\w+[^\d]$/, :message => "Place of Birth contains non alphabetical characters or not in the format City, Country"}
  validates_date :national_id_expiry_date, :after => lambda { Date.current } , :allow_blank => true
  validates_date :passport_expiry_date, :after => lambda { Date.current } , :allow_blank => true
  
  #validates_attachment_presence :photo
  #validates_attachment_content_type :photo, :content_type=>['image/jpeg', 'image/png', 'image/gif'], :message => 'Image must be of type jpeg, png or gif'
  validates_date :date_of_birth, :passport_expiry_date, :national_id_expiry_date , :allow_blank => true

  validates_inclusion_of :gender, :in => ["Female", "Male"]
  validates_inclusion_of :military_status, :in => ["Completed", "Exempted","Postponed", "Does not apply"]
  validates_inclusion_of :transportation, :in => ["Private", "Nu buses"]
  validates :national_id, :format => {:with => /^[0-9]*$/ , :message => "Invalid Number"}
  validates :passport_number, :format => {:with => /^[0-9a-zA-Z]*$/ , :message => "Invalid Number"}
  validates_uniqueness_of :national_id, :case_sensitive => false, :message => "National ID has already been taken", :allow_blank => true
  validates_uniqueness_of :passport_number, :case_sensitive => false, :message => "Passport Number has already been taken", :allow_blank => true
  
  validates :country_of_issuance, inclusion: { in: ActionView::Helpers::FormOptionsHelper::COUNTRIES }, :allow_blank => true
  
  #CONTINUE VALIDATION  
  
  #validate :passport_must_be_unique
  #validate :national_must_be_unique

  #def passport_must_be_unique
  #  return if passport_number.blank?
  #  num_duplicates = self.class.count(:conditions => ["passport_number = ?", passport_number])
  #  if num_duplicates > 1 #not 0 because i already saved it..
  #    errors.add(:passport_number, :taken)
  #  end
  #end
  
  #def national_must_be_unique
  #  return if national_id.blank?
  #  num_duplicates = Applicant.count(:conditions => ["national_id = ?", national_id])
  #  logger.debug "National COUNT!!!!!!!!!!!!!!"
  #  logger.debug num_duplicates
  #  if num_duplicates > 1 #not 0 because i already saved it.. 
  #    errors.add(:national_id, :taken)
  #  end
  #end
  
  
  attr_writer :current_step
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :admission_information,  :guardians, :attachment,  :uni_related_info 
  accepts_nested_attributes_for :colleges,:secondary_schools,:healths, :works, :allow_destroy => true
  # attr_accessor :reasons
  # attr_accessor :reasons2
  # attr_accessor :checkSecondary
  # attr_accessor :checkCollege
  # attr_accessor :checkWork
  
  #validates_presence_of :addresses, :message => "not exist in the DB"
  #validates_associated :addresses, :admission_information,:guardians, :secondary_schools, :colleges, :works, :attachment, :healths, :uni_related_info #,  :update
  validate :a_number_present
  validate :date_present
  validates_associated :addresses,:guardians, :secondary_schools, :colleges, :works, :healths #,  :update
  
  def to_s
    return "#{first_name} #{last_name}"
  end
  
  def display_name
    return "#{first_name} #{last_name}"
  end
  
  def a_number_present 
    errors.add(:national_id, "can't be blank") if national_id.blank? && passport_number.blank? 
    errors.add(:passport_number, "can't be blank") if national_id.blank? && passport_number.blank? 
  end
  
  def date_present 
    errors.add(:national_id_expiry_date, "can't be blank") if !national_id.blank? and national_id_expiry_date.blank?
    errors.add(:country_of_issuance, "can't be blank") if !passport_number.blank? and country_of_issuance.blank?
    errors.add(:passport_expiry_date, "can't be blank") if !passport_number.blank? and passport_expiry_date.blank?
  end
  
  def atleast_one
    logger.debug "address sizeeeee s333333333333333333333333333333333333333333333333333"
    logger.debug addresses
  end
    
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[applicant address admission_information]
  end
  
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end
  
  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end
  
  def first_step?
    current_step == steps.first
  end
  
  def last_step?
    current_step == steps.last
  end

   
end
