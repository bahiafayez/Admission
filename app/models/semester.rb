class Semester < ActiveRecord::Base
  has_many :admission_informations
  
  def to_s
    name
  end
end
