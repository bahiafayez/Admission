class ApplicantsController < ApplicationController
  def index
  end

  def new
    #session[:applicant_params] ||= {}
    
    #don't need to write anything here, since it creates (new+save) in the create action
    @applicant = Applicant.new()
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
    
    
     @applicant = Applicant.new( params[:applicant] )
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
        if @applicant.save(:validate => false)
          format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "new" }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
   else
    
      respond_to do |format|
        if @applicant.save
          format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
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
    @applicant = Applicant.find(params[:id])
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
        if @applicant.save(:validate => false)
          format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "new" }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
   else
    
      respond_to do |format|
        if @applicant.save
          format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
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
