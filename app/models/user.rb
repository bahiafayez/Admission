class User < ActiveRecord::Base
  has_one :applicant, :dependent => :destroy
  
  #attr_accessible :email, :password, :password_confirmation
  #to limit mass assignment to email, password and password_confirmation, to prevent anyone from changing
  # the password hash or the salt..
  
  attr_accessor :password #since not defined in model.. not in table.
  before_save :encrypt_password
  
  validates_confirmation_of :password #automatically adds password confirmation attribute
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Invalid E-mail"}
  
  accepts_nested_attributes_for :applicant
  
  def self.authenticate(email, password) #class method
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
end
