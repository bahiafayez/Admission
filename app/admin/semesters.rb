ActiveAdmin.register Semester do
  menu :if => proc{ can?(:manage, Semester) }, :parent => "Schools and Semesters"
  actions :index, :show, :new, :create, :edit, :update
  
  action_item only:[:index] do
   link_to "Open", "/admin/semesters/open"
 end
 
 action_item only:[:index] do
   link_to "Close", "/admin/semesters/close"
 end
 
 collection_action :open do
 end
 
 collection_action :close do
 end
 
 collection_action :semesters_open, :method => :post do
    
    semester=params[:semester]
    
    
    if params[:all_semesters]=="1"
      semester=[]
      Semester.all.each do |s|
        semester<<s.id
      end
    end
    
    
    if semester.nil?
      redirect_to "/admin/semesters/open", :alert => "Select at least one semester"
    else
        semester.each do |s|
          if s!=nil
            ss=Semester.find(s)
            ss.status=true
            ss.save
          end
        end
        
          redirect_to "/admin/semesters", :notice => "Semesters are now open"
        
    end
  end
  
  collection_action :semesters_close, :method => :post do
    
    semester=params[:semester]
    
    
    if params[:all_semesters]=="1"
      semester=[]
      Semester.all.each do |s|
        semester<<s.id
      end
      semester<<nil
    end
    
    
    if semester.nil?
      redirect_to "/admin/semesters/close", :alert => "Select at least one semester"
    else
      logger.debug "here" 
        @apps= Applicant.joins(:admission_information).where(:admission_informations => { :semester_id => semester}).readonly(false)
        @to=[]
        @apps.each do |a|
          if a.status!="Approved" and a.status!="Rejected"
            a.closed=true
            a.save(:validate => false)
            @to << a.user.email
          end
        end
        
        logger.debug semester 
        semester.each do |s|
          if s!=nil
            ss=Semester.find(s)
            ss.status=false
            ss.save
          end
        end
        
        if @to.nil? or @to.size==0
          redirect_to "/admin/semesters", :alert => "Semesters closed but no email was sent since no applicants enrolled in specified semesters"
        else
          ApplicationNotifier.close_email(@to).deliver
          redirect_to "/admin/semesters", :notice => "Semesters closed and Emails sent"
        end
    end
  end
  
 
 
  show  do |app|
    panel "Semester Details" do
    attributes_table_for semester do

        row :name
        row :status do
        
          if app.status==true
            "Available"
          elsif app.status==false
            "Not Available"
          else
            app.status
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
        #f.input :status, :label => "Available"
      
      f.buttons
    end
  end
end
