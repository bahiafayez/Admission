ActiveAdmin.register Applicant do
  
 ActiveAdmin.register Applicant do
  menu :parent => "Applicant Information"
 end
 
 
 
 ActiveAdmin.register Guardian do
  menu :parent => "Applicant Information"
 end
 
 ActiveAdmin.register Health do
  menu :parent => "Applicant Information"
 end
 
 ActiveAdmin.register College do
  menu :parent => "Education"
 end
 
 ActiveAdmin.register SecondarySchool do
  menu :parent => "Education"
 end
 
 
 
 ActiveAdmin.register Work do
  menu :parent => "Work Experience"
 end

 
 

end
