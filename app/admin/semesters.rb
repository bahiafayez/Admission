ActiveAdmin.register Semester do
  menu :parent => "Programs and Semesters"
  show  do |app|
    panel "Semester Details" do
    attributes_table_for semester do

        row :name
        row :status do
        
          if app.status==true
            "Available"
          else
            "Not Available"
          end
        end        
        row :created_at
        row :updated_at
     end
     end 
  end
  
  form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :status, :label => "Available"
      
      f.buttons
    end
  end
end
