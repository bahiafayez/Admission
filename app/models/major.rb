class Major < ActiveRecord::Base
  has_many :admission_informations
  belongs_to :school
  
  
  def to_s
    name
  end
end
