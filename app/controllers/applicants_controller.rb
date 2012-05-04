class ApplicantsController < ApplicationController
   before_filter :authenticate_user!, :except => [:get_semester]
   before_filter :correct_user, :only => [:edit, :update, :show, :destroy]
   
  # def index
#     
    # @applications =  Applicant.order('created_at DESC').page params[:page]
#   
    # respond_to do |format|
      # format.html # index.html.erb
      # format.json { render json: @applications }
    # end
#     
  # end
  
  def instance
    @applicant = Applicant.find(params[:id])
  end

  def new
    #session[:applicant_params] ||= {}
    if flash[:flag]== true
      logger.debug "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    #logger.debug @flag
    logger.debug flash[:flag]
    
    
    @user=User.find(current_user.id)
    
    #don't need to write anything here, since it creates (new+save) in the create action
    @applicant = @user.build_applicant
    
    @applicant.healths.build
    @applicant.secondary_schools.build 
    @applicant.works.build
    @applicant.colleges.build
    #2.times do
    
    #end
   
    2.times do
      @applicant.addresses.build
      @applicant.guardians.build
      
    end
    
    @applicant.admission_information= AdmissionInformation.new
    @applicant.attachment = Attachment.new
    @applicant.uni_related_info = UniRelatedInfo.new
    
    @applicant.uni_related_info.uni_choice= UniChoice.new
    @applicant.uni_related_info.other_choice= OtherChoice.new
    
    #logger.debug "in new action"
    #logger.debug(@applicant.addresses)
     
    else
      redirect_to root_path,:notice => "redirected to root"
      
    end
    
    
  end

  def create
    
     @user=User.find(current_user.id)
     @applicant= @user.build_applicant(params[:applicant])
     
     
    if Semester.where(:status => true).count==0 || School.where(:status => true).count==0 
      redirect_to @user, notice: 'Sorry, Admission Closed.'
      
    else
     #@applicant = Applicant.new( params[:applicant] )
     #logger.debug "Applicant isssssssssssssss"
     #logger.debug @applicant.attributes
     #parameters=params[:applicant][:guardian_attributes]
     #logger.debug "Guardian Attributes!!!!!!!!!!!!!!"
     # if params[:applicant][:checkSecondary][:oneSchool]=="1"
      # @school='checked'
     # end
     #logger.debug ""
     
     #Saving here, to save the image incase submission fails
     #To save image
     @applicant.save(:validate => false)
     
     
     
     @applicant.guardians.each do |guardian|
       guardian.relation3=guardian.relation
       if guardian.relation=="Other"
         guardian.relation=guardian.relation2
       end
     end
     
     # logger.debug "Reasons!!!!!!!!"
     # logger.debug params[:applicant][:reasons]
     # logger.debug "Reasons2222!!!!!!!!"
     # logger.debug params[:applicant][:reasons2]
#      
     # @reasons="" 
     # params[:applicant][:reasons].each do |parameter, value|
       # if value == "1"
         # @reasons<<"#{parameter} "
       # end
       # if value != "0" and value != "1" and value != ""
         # @reasons<<"#{value} "
       # end
     # end 
#      
     # logger.debug "reasons"
     # logger.debug @reasons
#      
     # @reasons2="" 
     # params[:applicant][:reasons2].each do |parameter, value|
       # if value == "1"
         # @reasons2<<"#{parameter} "
       # end
       # if value != "0" and value != "1" and value != ""
         # @reasons2<<"#{value} "
       # end
     # end 
     
     @reasons="" 
     @reasons<<"Internet \n" if @applicant.uni_related_info.uni_choice.internet
     @reasons<<"Email \n" if @applicant.uni_related_info.uni_choice.email
     @reasons<<"Radio \n" if @applicant.uni_related_info.uni_choice.radio
     @reasons<<"School Visits \n" if @applicant.uni_related_info.uni_choice.school_visits
     @reasons<<"Nile University faculty/staff \n " if @applicant.uni_related_info.uni_choice.nile_university_faculty_and_staff
     @reasons<<"Nile University Student/Alumni \n" if @applicant.uni_related_info.uni_choice.nile_university_student_and_alumni
     @reasons<<"Print Advertisements " if @applicant.uni_related_info.uni_choice.print_advertisements
     @reasons<<"#{@applicant.uni_related_info.uni_choice.specify_print_advertisements} \n" if @applicant.uni_related_info.uni_choice.specify_print_advertisements != nil
     @reasons<<"NU Seminar, Workshop and Conference " if @applicant.uni_related_info.uni_choice.nu_seminar_workshop_and_conference
     @reasons<<"#{@applicant.uni_related_info.uni_choice.specify_nu_seminar} \n" if @applicant.uni_related_info.uni_choice.specify_nu_seminar != nil
     @reasons<<"Other " if @applicant.uni_related_info.uni_choice.other
     @reasons<<"#{@applicant.uni_related_info.uni_choice.specify_other} \n" if @applicant.uni_related_info.uni_choice.specify_other != nil
     
     @reasons2="" 
     @reasons2<<"Quality of education \n" if @applicant.uni_related_info.other_choice.quality
     @reasons2<<"Reputation \n" if @applicant.uni_related_info.other_choice.reputation
     @reasons2<<"Facilities \n" if @applicant.uni_related_info.other_choice.facilities
     @reasons2<<"Location \n" if @applicant.uni_related_info.other_choice.location
     @reasons2<<"Fields of study " if @applicant.uni_related_info.other_choice.fields_of_study
     @reasons2<<"#{@applicant.uni_related_info.other_choice.specify_fields_of_study} \n" if @applicant.uni_related_info.other_choice.specify_fields_of_study != nil
     @reasons2<<"Other " if @applicant.uni_related_info.other_choice.other
     @reasons2<<"#{@applicant.uni_related_info.other_choice.specify_other} \n" if @applicant.uni_related_info.other_choice.specify_other != nil
     
     
     @applicant.uni_related_info.hear_of_uni=@reasons
     @applicant.uni_related_info.factors_other_universities=@reasons2
     
     if @applicant.military_status==nil
       @applicant.military_status="Does not apply"
     end 
     
      if @applicant.gender=="Female"
       @applicant.military_status="Does not apply"
     end
     
     
     # if @applicant.secondary_schools.size == 2
       # if @applicant.secondary_schools[0].id > @applicant.secondary_schools[1].id 
         # @temp= @applicant.secondary_schools[0]
         # @applicant.secondary_schools[0]= @applicant.secondary_schools[1]
         # @applicant.secondary_schools[1]= @temp
       # end
     # end
     
     
     
     #@applicant.guardians[0].relation="Mother"
     #logger.debug @applicant.guardians[0].relation
      if params[:save]
        @applicant.status="Saved"
        
        respond_to do |format|
        if @applicant.save(:validate => false)
          format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "new" }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
      elsif params[:cont]
        @applicant.status="Saved"
        respond_to do |format|
        if @applicant.save(:validate => false)         
          format.html { redirect_to edit_applicant_path(@applicant), notice: 'Saved' }
         end      
      end
   else
    
     #before validation..
     # delete extra address
     logger.debug "Before Validation"
     if @applicant.addresses[0].address_type=="Both"
       @b=@applicant.addresses[1]
       if @b != nil
         @applicant.addresses.destroy(@b)
       end
     elsif @applicant.addresses[1].address_type=="Both"
       @b=@applicant.addresses[0]
       if @b != nil
         @applicant.addresses.destroy(@b)     
       end
     end
     
        # delete extra secondary schools
     # if @applicant.checkSecondary
       # @b=@applicant.secondary_schools[1]
       # if @b != nil
         # @applicant.secondary_schools.destroy(@b)
       # end
     # end
#      
     # # delete extra Colleges 
     # if @applicant.checkCollege
       # @b=@applicant.colleges[1]
       # if @b != nil
         # @applicant.colleges.destroy(@b)
       # end
     # end
#      
     # # delete extra Work
     # if @applicant.checkWork
       # @b=@applicant.works[1]
       # if @b != nil
         # @applicant.works.destroy(@b)
       # end
     # end
       
     
     logger.debug @applicant.addresses    
     logger.debug "checking!!!!!!!!!!!!!!!!!!!!!!!"
    #logger.debug params[:applicant][:checkSecondary][:oneSchool]
    @applicant.status="Submitted"
    logger.debug @user.attributes
    
      respond_to do |format|
        if @applicant.save
          
          html = render_to_string(:layout => false , :action => "show.html.erb")
          kit = PDFKit.new(html)
          kit.stylesheets << "#{Rails.root}/public/stylesheets/style2.css"
          email= kit.to_pdf
          
          ApplicationNotifier.submitted(@applicant.user,email).deliver
          format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          #@user.save(:validate => false)
          logger.debug "ERRORS IN NEW!!!!!!!!!!"
          logger.debug @user.errors
          #error was becasue of password.. so instead saving applicant, since don't need to save user.
          @user.errors.each{|attr,msg| logger.debug "#{attr} - #{msg}" } 
          format.html { render action: "new", notice: "errorrrrrrrrrrr" }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
     end
    end
  end
  def edit
    logger.debug "IN EDIT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    @applicant = Applicant.find(params[:id])
    if @applicant.closed==true or @applicant.status=="Approved" or @applicant.status=="Rejected" or Semester.where(:status => true).count==0 or School.where(:status => true).count==0
      redirect_to @applicant, notice: "Sorry Admission Closed"
    end
    @applicant.guardians.each do |guardian|
       guardian.relation3=guardian.relation
       if guardian.relation!="Mother" and guardian.relation!="Father"
         guardian.relation3="Other"
       end
     end
     
  end
  
  def update
    
    
    @user=User.find(current_user.id)
    #@applicant= @user.build_applicant(params[:applicant])
    @applicant=@user.applicant 
    
    if @applicant.closed== true or @applicant.status=="Approved" or @applicant.status=="Rejected" or Semester.where(:status => true).count==0 or School.where(:status => true).count==0
      redirect_to @user.applicant, notice: 'Sorry, Admission Closed.'
      logger.debug "in here in update condition!!!!!"
    else
     
    #@applicant = Applicant.find(params[:id])
    #logger.debug "GENDERRRRRRRRRRRRRRR"
    #logger.debug params[:applicant]
    #logger.debug "GENDER AFTER CAST"
    #params[:applicant][:gender]=params[:applicant][:gender].to_i
    #logger.debug params[:applicant]
    
    # if params[:applicant][:checkSecondary][:oneSchool]=="1"
      # @school='checked'
    # end
    
    
    @applicant.attributes=params[:applicant]
    

    #To save image
    @applicant.save(:validate => false)
    
    @applicant.guardians.each do |guardian|
       guardian.relation3=guardian.relation
       if guardian.relation=="Other"
         guardian.relation=guardian.relation2
       end
     end
     
    
     
       
     @reasons="" 
     @reasons<<"Internet \n" if @applicant.uni_related_info.uni_choice.internet
     @reasons<<"Email \n" if @applicant.uni_related_info.uni_choice.email
     @reasons<<"Radio \n" if @applicant.uni_related_info.uni_choice.radio
     @reasons<<"School Visits \n" if @applicant.uni_related_info.uni_choice.school_visits
     @reasons<<"Nile University faculty/staff \n " if @applicant.uni_related_info.uni_choice.nile_university_faculty_and_staff
     @reasons<<"Nile University Student/Alumni \n" if @applicant.uni_related_info.uni_choice.nile_university_student_and_alumni
     @reasons<<"Print Advertisements " if @applicant.uni_related_info.uni_choice.print_advertisements
     @reasons<<"#{@applicant.uni_related_info.uni_choice.specify_print_advertisements} \n" if @applicant.uni_related_info.uni_choice.specify_print_advertisements != nil
     @reasons<<"NU Seminar, Workshop and Conference " if @applicant.uni_related_info.uni_choice.nu_seminar_workshop_and_conference
     @reasons<<"#{@applicant.uni_related_info.uni_choice.specify_nu_seminar} \n" if @applicant.uni_related_info.uni_choice.specify_nu_seminar != nil
     @reasons<<"Other " if @applicant.uni_related_info.uni_choice.other
     @reasons<<"#{@applicant.uni_related_info.uni_choice.specify_other} \n" if @applicant.uni_related_info.uni_choice.specify_other != nil
     
     @reasons2="" 
     @reasons2<<"Quality of education \n" if @applicant.uni_related_info.other_choice.quality
     @reasons2<<"Reputation \n" if @applicant.uni_related_info.other_choice.reputation
     @reasons2<<"Facilities \n" if @applicant.uni_related_info.other_choice.facilities
     @reasons2<<"Location \n" if @applicant.uni_related_info.other_choice.location
     @reasons2<<"Fields of study " if @applicant.uni_related_info.other_choice.fields_of_study
     @reasons2<<"#{@applicant.uni_related_info.other_choice.specify_fields_of_study} \n" if @applicant.uni_related_info.other_choice.specify_fields_of_study != nil
     @reasons2<<"Other " if @applicant.uni_related_info.other_choice.other
     @reasons2<<"#{@applicant.uni_related_info.other_choice.specify_other} \n" if @applicant.uni_related_info.other_choice.specify_other != nil
     
     
     @applicant.uni_related_info.hear_of_uni=@reasons
     @applicant.uni_related_info.factors_other_universities=@reasons2
     
     if @applicant.military_status==nil
       @applicant.military_status="Does not apply"
     end
     
     if @applicant.gender=="Female"
       @applicant.military_status="Does not apply"
     end
     
     
     # if @applicant.secondary_schools.size == 2
       # if @applicant.secondary_schools[0].id > @applicant.secondary_schools[1].id 
         # @temp= @applicant.secondary_schools[0]
         # @applicant.secondary_schools[0]= @applicant.secondary_schools[1]
         # @applicant.secondary_schools[1]= @temp
       # end
     # end
     
      if params[:save]
        @applicant.status="Saved"
        respond_to do |format|
        if @applicant.save(:validate => false)
          format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "edit" }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
      elsif params[:cont]
        @applicant.status="Saved"
        respond_to do |format|
        if @applicant.save(:validate => false)         
          format.html { redirect_to edit_applicant_path(@applicant), notice: 'Saved' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "edit" }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
       
        end      
      end
      
   else
     
     
     #before validation..
     # delete extra address
     logger.debug "Before Validation"
     if @applicant.addresses[0].address_type=="Both"
       @b=@applicant.addresses[1]
       if @b != nil
         @applicant.addresses.destroy(@b)
       end
     elsif @applicant.addresses[1]!=nil and @applicant.addresses[1].address_type=="Both"
       @b=@applicant.addresses[0]
       if @b != nil
         @applicant.addresses.destroy(@b)     
       end
     end
     # # delete extra secondary schools
     # if @applicant.checkSecondary
       # @b=@applicant.secondary_schools[1]
       # if @b != nil
         # @applicant.secondary_schools.destroy(@b)
       # end
     # end
#      
     # # delete extra Colleges 
     # if @applicant.checkCollege
       # @b=@applicant.colleges[1]
       # if @b != nil
         # @applicant.colleges.destroy(@b)
       # end
     # end
#      
     # # delete extra Work
     # if @applicant.checkWork
       # @b=@applicant.works[1]
       # if @b != nil
         # @applicant.works.destroy(@b)
       # end
     # end
     
     logger.debug @applicant.addresses    
     logger.debug "checking!!!!!!!!!!!!!!!!!!!!!!!"
    #logger.debug params[:applicant][:checkSecondary][:oneSchool]
    
      @applicant.status="Submitted"
      respond_to do |format|
        if @applicant.save 
          logger.debug "NO ERRORRSSSSSSSSSSS"
         
          html = render_to_string(:layout => false , :action => "show.html.erb")
          kit = PDFKit.new(html)
          kit.stylesheets << "#{Rails.root}/public/stylesheets/style2.css"
          email= kit.to_pdf
              
          ApplicationNotifier.submitted(@applicant.user, email).deliver
          format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          logger.debug "ERRORS!!!!!!!!!!!!!!!!!!!"
          #To save image
          #@user.save(:validate => false)
          format.html { render action: "edit", notice: 'errors' }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
     end
   end
  end
  

  def destroy
  end
  
  def show
    @applicant = Applicant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @applicant }
      #format.pdf { send_data render_to_pdf({ :action => 'show', :layout => 'pdf_report' }) }  
      format.pdf {
        html = render_to_string(:layout => false , :action => "show.html.erb")
        kit = PDFKit.new(html)
        kit.stylesheets << "#{Rails.root}/public/stylesheets/style2.css"
        send_data(kit.to_pdf, :filename => "NU Application.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
    end
  end
  
  def update_major_select
    val = params[:school_id]
    #Use val to find records
    logger.debug "val isssssssssssssssss"
    logger.debug val
    majors = Major.where(:school_id=>params[:school_id] , :status => true).order(:name) unless params[:school_id].blank?
    #render :partial => "majors", :locals => { :majors => majors }

    options = majors.collect{|x| "\"#{x.id}\" : \"#{x.name}\""}    
    render json: "{#{options.join(",")}}" 
  end
  
  def get_semester
    val = params[:sem]
    #Use val to find records
    logger.debug "val isssssssssssssssss"
    logger.debug val
    all= Applicant.joins(:admission_information).where(:admission_informations => { :semester_id => val}).readonly(false).count
    saved= Applicant.joins(:admission_information).where(:applicants => {:status => "Saved"}, :admission_informations => { :semester_id => val}).readonly(false).count
    submitted= Applicant.joins(:admission_information).where(:applicants => {:status => "Submitted"}, :admission_informations => { :semester_id => val}).readonly(false).count
    approved= Applicant.joins(:admission_information).where(:applicants => {:status => "Approved"}, :admission_informations => { :semester_id => val}).readonly(false).count
    rejected= Applicant.joins(:admission_information).where(:applicants => {:status => "Rejected"}, :admission_informations => { :semester_id => val}).readonly(false).count
    closed= Applicant.joins(:admission_information).where(:applicants => {:closed => true}, :admission_informations => { :semester_id => val}).readonly(false).count
    
    
    #render :partial => "majors", :locals => { :majors => majors }

    #options = majors.collect{|x| "\"#{x.id}\" : \"#{x.name}\""}    
    render json: "{\"all\":\"#{all}\", \"saved\":\"#{saved}\", \"submitted\": \"#{submitted}\", \"approved\": \"#{approved}\", \"rejected\" : \"#{rejected}\", \"closed\": \"#{closed}\" }" 
  end
end
