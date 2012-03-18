class Semester < ActiveRecord::Base
  has_many :admission_informations
end
