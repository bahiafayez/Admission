ActiveAdmin.register Semester do
  menu :parent => "Schools and Semesters"
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
   
   
  
   # panel "Applicants" do
   # table_for  Applicant.joins(:admission_information).where(:admission_informations => { :semester_id => semester.id }) do
    # column :id do |app|
      # link_to app.id, admin_applicant_path(app)
    # end
    # column :first_name do |app|
      # link_to app.first_name, admin_applicant_path(app)
    # end
    # column :middle_name
    # column :last_name
    # column :last_sign_in do |app|
      # app.user.last_sign_in_at
    # end
    # column :status do |app|
      # strong {app.status}
    # end
    # column :notes
     # end
  # end
 end
  form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :status, :label => "Available"
      
      f.buttons
    end
  end
end
