ActiveAdmin.register School do
  
  menu :if => proc{ can?(:manage, School) } , :parent => "Schools and Semesters"    
  controller.authorize_resource
  
 # menu 
  actions :index, :show, :new, :create, :edit, :update
  show  do |app|
    panel "School Details" do
    attributes_table_for school do

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
     
    panel "Majors" do
    table_for school.majors do
      column "Name" do |major|
        major.name
      end
      column "Status" do |major|
        major.status
      end
    end  
  end
  
  end
  
  form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :status, :label => "Available"
      
    end
    
    f.has_many :majors do |major|
    #major.inputs "Majors" do
      logger.debug 'major isssssssssssssss1111'
      logger.debug major.object
      if !major.object.nil?
        logger.debug 'major isssssssssssssss'
        logger.debug major.object
        # show the destroy checkbox only if it is an existing appointment
        # else, there's already dynamic JS to add / remove new appointments
        major.input :_destroy, :as => :boolean, :label => "Destroy?"
      end

      major.input :name
      major.input :status, :label => "Available"
      #repeat as necessary for all fields
    #end
  end
   f.buttons
  end
end


# panel "User Details" do
                # attributes_table_for user, 
                        # :id,
                        # :first_name,
                        # :last_name,
                        # :email
        # end