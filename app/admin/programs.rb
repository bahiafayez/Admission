ActiveAdmin.register Program do
  show  do |app|
    panel "Program Details" do
    attributes_table_for program do

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


# panel "User Details" do
                # attributes_table_for user, 
                        # :id,
                        # :first_name,
                        # :last_name,
                        # :email
        # end