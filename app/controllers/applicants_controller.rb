class ApplicantsController < ApplicationController
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
     @applicant.guardians.each do |guardian|
       if guardian.relation=="Other"
         guardian.relation=guardian.relation2
       end
     end
     
     logger.debug "Reasons!!!!!!!!"
     logger.debug params[:applicant][:reasons]
     logger.debug "Reasons2222!!!!!!!!"
     logger.debug params[:applicant][:reasons2]
     
     @reasons="" 
     params[:applicant][:reasons].each do |parameter, value|
       if value == "1"
         @reasons<<"#{parameter} "
       end
       if value != "0" and value != "1" and value != ""
         @reasons<<"#{value} "
       end
     end 
     
     logger.debug "reasons"
     logger.debug @reasons
     
     @reasons2="" 
     params[:applicant][:reasons2].each do |parameter, value|
       if value == "1"
         @reasons2<<"#{parameter} "
       end
       if value != "0" and value != "1" and value != ""
         @reasons2<<"#{value} "
       end
     end 
     
     @applicant.uni_related_info.hear_of_uni=@reasons
     @applicant.uni_related_info.factors_other_universities=@reasons2
     
      
     #@applicant.guardians[0].relation="Mother"
     #logger.debug @applicant.guardians[0].relation
      if params[:save]
        
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
     if params[:applicant][:checkSecondary][:oneSchool]=="1"
       @b=@applicant.secondary_schools[1]
       if @b != nil
         @applicant.secondary_schools.destroy(@b)
       end
     end
     
     # delete extra Colleges 
     if params[:applicant][:checkCollege][:oneCollege]=="1"
       @b=@applicant.colleges[1]
       if @b != nil
         @applicant.colleges.destroy(@b)
       end
     end
     
     # delete extra Work
     if params[:applicant][:checkWork][:oneWork]=="1"
       @b=@applicant.works[1]
       if @b != nil
         @applicant.works.destroy(@b)
       end
     end
       
     
     logger.debug @applicant.addresses    
     logger.debug "checking!!!!!!!!!!!!!!!!!!!!!!!"
    logger.debug params[:applicant][:checkSecondary][:oneSchool]
    
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "new" }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
     end
    
  end
  def edit
    @applicant = Applicant.find(params[:id])
  end
  
  def update
    
    @user=User.find(session[:user_id])
    #@applicant= @user.build_applicant(params[:applicant])
    @applicant=@user.applicant 
     
    #@applicant = Applicant.find(params[:id])
    @applicant.attributes=params[:applicant]

    @applicant.guardians.each do |guardian|
       if guardian.relation=="Other"
         guardian.relation=guardian.relation2
       end
     end
     
    
     
     @reasons="" 
     params[:applicant][:reasons].each do |parameter, value|
       if value == "1"
         @reasons<<"#{parameter} "
       end
       if value != "0" and value != "1" and value != ""
         @reasons<<"#{value} "
       end
     end 
     
     @reasons2=""
     params[:applicant][:reasons2].each do |parameter, value|
       if value == "1"
         @reasons2<<"#{parameter} "
       end
       if value != "0" and value != "1" and value != ""
         @reasons2<<"#{value} "
       end
     end 
     
     @applicant.uni_related_info.hear_of_uni=@reasons
     @applicant.uni_related_info.factors_other_universities=@reasons2
     
     
      if params[:save]
        
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
     elsif @applicant.addresses[1]!=nil and @applicant.addresses[1].address_type=="Both"
       @b=@applicant.addresses[0]
       if @b != nil
         @applicant.addresses.destroy(@b)     
       end
     end
     # delete extra secondary schools
     if params[:applicant][:checkSecondary][:oneSchool]=="1"
       @b=@applicant.secondary_schools[1]
       if @b != nil
         @applicant.secondary_schools.destroy(@b)
       end
     end
     
     # delete extra Colleges 
     if params[:applicant][:checkCollege][:oneCollege]=="1"
       @b=@applicant.colleges[1]
       if @b != nil
         @applicant.colleges.destroy(@b)
       end
     end
     
     # delete extra Work
     if params[:applicant][:checkWork][:oneWork]=="1"
       @b=@applicant.works[1]
       if @b != nil
         @applicant.works.destroy(@b)
       end
     end
     
     logger.debug @applicant.addresses    
     logger.debug "checking!!!!!!!!!!!!!!!!!!!!!!!"
    logger.debug params[:applicant][:checkSecondary][:oneSchool]
    
    
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user.applicant, notice: 'Applicant was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "new" }
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
