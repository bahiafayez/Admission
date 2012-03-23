ActiveAdmin.register Applicant do
  
  action_item only:[:show] do
   link_to "Approve", "/admin/applicants/#{applicant.id}/accept"
 end
 
 action_item only:[:show] do
   link_to "Reject", "/admin/applicants/#{applicant.id}/reject"
 end
 
 action_item only:[:show] do
   link_to "Download PDF", admin_applicant_path(applicant, :format => "pdf")
 end
 
 action_item only:[:show] do
   link_to "Email Applicant", "/admin/applicants/#{applicant.id}/email"
 end
 
 controller do
  def show
    @applicant = Applicant.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf {
        html = render_to_string( :action => "show.html.erb")
        kit = PDFKit.new(html, :orientation => 'Landscape')
        kit.stylesheets << "#{Rails.root}/public/stylesheets/style3.css"
        
        send_data(kit.to_pdf, :filename => "NU Application.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
    end
  end
end
 
  member_action :saveaccept, :method =>:put do
      applicant = Applicant.find(params[:id])
      applicant.notes=params[:applicant][:notes]  
      applicant.status="Approved"
       if applicant.save
          #format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
          ApplicationNotifier.reason(applicant.user).deliver
          redirect_to "/admin/applicants/#{params[:id]}", :notice => "Applicant accepted"
        else
          #@user.save(:validate => false)
          logger.debug "ERRORS IN NEW!!!!!!!!!!"
          logger.debug applicant.errors
          #error was becasue of password.. so instead saving applicant, since don't need to save user.
          applicant.errors.each{|attr,msg| logger.debug "#{attr} - #{msg}" } 
          redirect_to "/admin/applicants/#{params[:id]}", :alert => "Applicant was not sucessfully saved"
        end
   
  end
  
  member_action :savereject, :method =>:put do
      applicant = Applicant.find(params[:id])
      applicant.notes=params[:applicant][:notes]  
      applicant.status="Rejected"
       if applicant.save
          #format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
          ApplicationNotifier.reason(applicant.user).deliver
          redirect_to "/admin/applicants/#{params[:id]}", :notice => "Applicant Rejected"
        else
          #@user.save(:validate => false)
          logger.debug "ERRORS IN NEW!!!!!!!!!!"
          logger.debug applicant.errors
          #error was becasue of password.. so instead saving applicant, since don't need to save user.
          applicant.errors.each{|attr,msg| logger.debug "#{attr} - #{msg}" } 
          redirect_to "/admin/applicants/#{params[:id]}", :alert => "Applicant was not sucessfully saved"
        end
   
  end
  
  member_action :accept do
      applicant = Applicant.find(params[:id])
      if applicant.status!= "Saved" and applicant.status!= "Just Created"
        #applicant.status="Approved"
        #applicant.save()
        @app= applicant
        #redirect_to "/admin/applicants/#{params[:id]}", :notice => "Approved"
      else
        redirect_to "/admin/applicants/#{params[:id]}", :alert => "Applicant has not submitted the application yet."
      end
  end
  
  member_action :reject do
      applicant = Applicant.find(params[:id])
      if applicant.status!= "Saved" and applicant.status!= "Just Created"
        #applicant.status="Rejected"
        #applicant.save()
        @app= applicant
        #redirect_to "/admin/applicants/#{params[:id]}", :notice => "Rejected"
      else
        redirect_to "/admin/applicants/#{params[:id]}", :alert => "Applicant has not submitted the application yet."
      end
  end

  member_action :email do
      applicant = Applicant.find(params[:id])
      @app= applicant
  end
  
   member_action :sendemail, :method =>:post do
      @applicant = Applicant.find(params[:id])
      @subject=params[:subject]
      @body=params[:body]
      ApplicationNotifier.email(@applicant.user,@subject, @body).deliver
      redirect_to "/admin/applicants/#{params[:id]}", :notice => "Email sent"
   
  end
  
  scope :all, :default => true
  scope :just_created do |applicants|
    applicants.where(:status => "Just Created")
  end
  scope :saved do |applicants|
    applicants.where(:status => "Saved")
  end
  scope :submitted do |applicants|
    applicants.where(:status => "Submitted")
  end
  scope :approved do |applicants|
    applicants.where(:status => "Approved")
  end
  scope :rejected do |applicants|
    applicants.where(:status => "Rejected")
  end
  
  #menu :parent => "Applicant Information"
  actions :index, :show
 
  index do
    column :id do |app|
      link_to app.id, admin_applicant_path(app)
    end
    column :first_name do |app|
      link_to app.first_name, admin_applicant_path(app)
    end
    column :middle_name
    column :last_name
    column :created_at
    column :updated_at
    column :status do |app|
      strong {app.status}
    end
    column :notes
    
  end
 
  show :title => :display_name  do |app|
    #h3 applicant.first_name
    
    panel "User Information" do
    attributes_table_for applicant.user do
      row :email
      row :password_hash
      row :password_salt
      row :created_at
      row :updated_at
    end
  end
    
    
      attributes_table do
        row :photo do
          if app.photo.file?
            link_to image_tag(app.photo.url(:thumb)), app.photo.url
          else
            "No Photo Uploaded"  
          end
        end
        row :first_name
        row :middle_name
        row :last_name
        row :date_of_birth
        row :place_of_birth
        row :gender
        
        row :military_status
        row :national_id
        row :national_id_expiry_date
        row :passport_number
        row :country_of_issuance
        row :passport_expiry_date
        
        row :academic_honours
        row :extra_activities
        row :transportation
        row :status
        row :notes
        row :created_at
        row :updated_at
        row :user_id
        

      end
  
    
  panel "Addresses" do
    table_for applicant.addresses do
      column "Address" do |address|
        address.address
      end
      column "Telephone" do |address|
        address.telephone
      end
      column "Mobile" do |address|
        address.mobile
      end
      column "Fax" do |address|
        address.fax
      end
      # column "Email" do |address|
        # address.email
      # end
      column "Address Type" do |address|
        address.address_type
      end
      column "Application" do |address|
        address.applicant_id
      end
      
    end
  end
  
  panel "Admission Information" do
    attributes_table_for applicant.admission_information do
      row :semester_id
      #row :applying_to
      row :toefl_test_results
      row :toefl_test_date
      row :proficiency_test
      row :program_id
      row :major_id
      row :applicant_id
    end
  end
  
  panel "Attachments" do
    attributes_table_for applicant.attachment do
      row :personal_experience do
        if app.attachment.personal_experience.file?  
          link_to image_tag(app.attachment.personal_experience.url(:thumb)), app.attachment.personal_experience.url
        else
          "No Document Uploaded"
        end  
      end
      row :additional_information do
        if app.attachment.additional_information.file?
          link_to image_tag(app.attachment.additional_information.url(:thumb)), app.attachment.additional_information.url
        else
          "No Document Uploaded"
        end
      end
    end
  end
  
  panel "Guardians" do
    table_for applicant.guardians do
      column "First Name" do |guardian|
        guardian.first_name
      end
      column "Middle Name" do |guardian|
        guardian.middle_name
      end
      column "Last Name" do |guardian|
        guardian.last_name
      end
      column "Address" do |guardian|
        guardian.address
      end
      column "Telephone" do |guardian|
        guardian.telephone
      end
      column "Mobile" do |guardian|
        guardian.mobile
      end
      column "Occupation" do |guardian|
        guardian.occupation
      end
      column "Company Name" do |guardian|
        guardian.company_name
      end
      column "Business Telephone" do |guardian|
        guardian.business_telephone
      end
      column "Email" do |guardian|
        guardian.email
      end
      column "Fax" do |guardian|
        guardian.fax
      end
      column "Business Address" do |guardian|
        guardian.business_address
      end
      column "Relationship to Applicant" do |guardian|
        guardian.relation
      end
      column "Financially Responsible for Applicant" do |guardian|
        guardian.financial
      end
      column "Application" do |guardian|
        guardian.applicant_id
      end
      
    end
  end
   panel "Secondary Schools" do
    table_for applicant.secondary_schools do
      column "Name" do |school|
        school.name
      end
      column "Address" do |school|
        school.address
      end
      column "Language" do |school|
        school.language
      end
      column "Attended From" do |school|
        school.attended_from
      end
      column "Attended To" do |school|
        school.attended_to
      end
      column "Certificate Type" do |school|
        school.certificate_type
      end
      column "Graduation Date" do |school|
        school.graduation_date
      end
      column "Division" do |school|
        school.division
      end
      column "School Type" do |school|
        school.school_type
      end
      column "Application" do |school|
        school.applicant_id
      end
      
    end
  end
  
     panel "Colleges" do
    table_for applicant.colleges do
      column "Name" do |college|
        college.name
      end
      column "Faculty" do |college|
        college.faculty
      end
      column "Major" do |college|
        college.major
      end
      column "City" do |college|
        college.city
      end
      column "Country" do |college|
        college.country
      end
      column "Attended From" do |college|
        college.attended_from
      end
      column "Attended To" do |college|
        college.attended_to
      end
      
      column "Language" do |college|
        college.language
      end
      column "GPA" do |college|
        college.gpa
      end
      column "Application" do |college|
        college.applicant_id
      end
      
    end
  end

    panel "Work" do
    table_for applicant.works do
      column "Employer" do |work|
        work.employer
      end
      column "Worked From" do |work|
        work.worked_from
      end
      column "Worked To" do |work|
        work.worked_to
      end
      column "Tasks" do |work|
        work.tasks
      end
      column "Application" do |work|
        work.applicant_id
      end
    end
  end
  
  panel "Health" do
    table_for applicant.healths do
      column "Illness" do |health|
        health.illness
      end
      column "Description" do |health|
        health.description
      end
    end
  end
  
  panel "University Related Information" do
    attributes_table_for applicant.uni_related_info do
      row :hear_of_uni
      row :factors
      row :majors
      row :other_universities
      row :factors_other_universities
      row :applicant_id
    end
  end
  
  
  #active_admin_comments
end #show

end
