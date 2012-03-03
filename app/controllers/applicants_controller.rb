class ApplicantsController < ApplicationController
   before_filter :authorize
  def index
    
    @applications =  Applicant.order('created_at DESC').page params[:page]
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
    
  end

  def new
    #session[:applicant_params] ||= {}
    @user=User.find(session[:user_id])
    
    #don't need to write anything here, since it creates (new+save) in the create action
    @applicant = @user.build_applicant
    #2.times do
    
    #end
    2.times do
      @applicant.addresses.build
      @applicant.colleges.build
      @applicant.guardians.build
      @applicant.healths.build
      @applicant.secondary_schools.build
      @applicant.works.build
    end
    
    @applicant.admission_information= AdmissionInformation.new
    @applicant.attachment = Attachment.new
    @applicant.uni_related_info = UniRelatedInfo.new
    
    @applicant.uni_related_info.uni_choice= UniChoice.new
    @applicant.uni_related_info.other_choice= OtherChoice.new
    
    #logger.debug "in new action"
    #logger.debug(@applicant.addresses)
    
  end

  def create
    
     @user=User.find(session[:user_id])
     @applicant= @user.build_applicant(params[:applicant])
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
     
     
     if @applicant.secondary_schools.size == 2
       if @applicant.secondary_schools[0].id > @applicant.secondary_schools[1].id 
         @temp= @applicant.secondary_schools[0]
         @applicant.secondary_schools[0]= @applicant.secondary_schools[1]
         @applicant.secondary_schools[1]= @temp
       end
     end
     
     
     
     #@applicant.guardians[0].relation="Mother"
     #logger.debug @applicant.guardians[0].relation
      if params[:save]
        @applicant.status="Saved"
        
        respond_to do |format|
        if @user.save(:validate => false)
          format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "new" }
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
     elsif @applicant.addresses[1].address_type=="Both"
       @b=@applicant.addresses[0]
       if @b != nil
         @applicant.addresses.destroy(@b)     
       end
     end
     
        # delete extra secondary schools
     if @applicant.checkSecondary
       @b=@applicant.secondary_schools[1]
       if @b != nil
         @applicant.secondary_schools.destroy(@b)
       end
     end
     
     # delete extra Colleges 
     if @applicant.checkCollege
       @b=@applicant.colleges[1]
       if @b != nil
         @applicant.colleges.destroy(@b)
       end
     end
     
     # delete extra Work
     if @applicant.checkWork
       @b=@applicant.works[1]
       if @b != nil
         @applicant.works.destroy(@b)
       end
     end
       
     
     logger.debug @applicant.addresses    
     logger.debug "checking!!!!!!!!!!!!!!!!!!!!!!!"
    #logger.debug params[:applicant][:checkSecondary][:oneSchool]
    @applicant.status="Submitted"
    logger.debug @user.attributes
    
      respond_to do |format|
        if @applicant.save
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
  def edit
    @applicant = Applicant.find(params[:id])
    if @applicant.status=="Submitted"
      redirect_to @applicant, notice: "Sorry Application Already Submitted"
    end
  end
  
  def update
    
    @user=User.find(session[:user_id])
    #@applicant= @user.build_applicant(params[:applicant])
    @applicant=@user.applicant 
     
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
     
     
     if @applicant.secondary_schools.size == 2
       if @applicant.secondary_schools[0].id > @applicant.secondary_schools[1].id 
         @temp= @applicant.secondary_schools[0]
         @applicant.secondary_schools[0]= @applicant.secondary_schools[1]
         @applicant.secondary_schools[1]= @temp
       end
     end
     
      if params[:save]
        @applicant.status="Saved"
        respond_to do |format|
        if @user.save(:validate => false)
          format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
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
     # delete extra secondary schools
     if @applicant.checkSecondary
       @b=@applicant.secondary_schools[1]
       if @b != nil
         @applicant.secondary_schools.destroy(@b)
       end
     end
     
     # delete extra Colleges 
     if @applicant.checkCollege
       @b=@applicant.colleges[1]
       if @b != nil
         @applicant.colleges.destroy(@b)
       end
     end
     
     # delete extra Work
     if @applicant.checkWork
       @b=@applicant.works[1]
       if @b != nil
         @applicant.works.destroy(@b)
       end
     end
     
     logger.debug @applicant.addresses    
     logger.debug "checking!!!!!!!!!!!!!!!!!!!!!!!"
    #logger.debug params[:applicant][:checkSecondary][:oneSchool]
    
      @applicant.status="Submitted"
      respond_to do |format|
        if @applicant.save 
          logger.debug "NO ERRORRSSSSSSSSSSS"
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

  def destroy
  end
  
  def show
    @applicant = Applicant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @applicant }
    end
  end
  
end
