class Major < ActiveRecord::Base
  has_many :admission_informations
  belongs_to :program
end
