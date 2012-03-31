class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_one :applicant, :dependent => :destroy
  
  #attr_accessible :email, :password, :password_confirmation
  #to limit mass assignment to email, password and password_confirmation, to prevent anyone from changing
  # the password hash or the salt..
  
  # attr_accessor :password #since not defined in model.. not in table.
  # before_save :encrypt_password
#   
  # validates_confirmation_of :password #automatically adds password confirmation attribute
  # validates_presence_of :password, :on => :create
  # validates :password,
          # :length => { :within => 6..40 }
  # validates_presence_of :email
  # validates_uniqueness_of :email, :case_sensitive => false, :message => "Email has already taken"
  # validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Invalid E-mail"}
#   
  accepts_nested_attributes_for :applicant
  
  def to_s
    email
  end
  
  # def self.authenticate(email, password) #class method
    # #user = find_by_email(email)
    # user= find(:all, :conditions => [ "lower(email) = ?", email.downcase ]).first
    # if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      # user
    # else
      # nil
    # end
  # end
#   
  # def encrypt_password
    # if password.present?
      # self.password_salt = BCrypt::Engine.generate_salt
      # self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    # end
  # end
  after_create :send_welcome_mail
  
  def send_welcome_mail
     ApplicationNotifier.created(self).deliver
  end
  
end
