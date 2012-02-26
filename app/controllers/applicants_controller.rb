class ApplicantsController < ApplicationController
  def index
  end

  def new
    session[:applicant_params] ||= {}
    
    #don't need to write anything here, since it creates (new+save) in the create action
    @applicant = Applicant.new(session[:applicant_params])
    #2.times do
      @addresses=@applicant.addresses.build
    #end
    logger.debug "in new action"
    logger.debug(@applicant.addresses)
    #@address= Address.new
    #@attachment = Attachment.new
   session[:address_params] = @addresses.attributes
    
  end

  def create
    
    session[:applicant_params].deep_merge!(params[:applicant]) if params[:applicant]
    session[:address_params] ||= params[:address]
     @applicant = Applicant.new( session[:applicant_params] )
     @applicant.addresses.new(session[:address_params])
     #@address = Address.new(session[:address_params])
     #@applicant.addresses=@address
     #@attachment = Attachment.new(params[:attachment])
     #@applicant.attachment = @attachment
    if params[:add]
      #@applicant.addresses.build
       render "new"
    else  
      
    if params[:forward_button] or params[:back_button]
      #navigation only.. no saving
      
      @applicant.current_step = session[:applicant_step] 
     
      if params[:back_button]
        @applicant.previous_step  
      else
        @applicant.next_step
      end
      
      session[:applicant_step]=@applicant.current_step
      
      render "new"
      
    else
    
    
    
     
      
      if params[:save]
        
        respond_to do |format|
        if @applicant.save(:validate => false)
          format.html { redirect_to @applicant, notice: 'Product was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "new" }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
      
      else
    
      respond_to do |format|
        if @applicant.save
          format.html { redirect_to @applicant, notice: 'Product was successfully created.' }
          format.json { render json: @applicant, status: :created, location: @applicant }
        else
          format.html { render action: "new" }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
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
    end
  end
  
end
