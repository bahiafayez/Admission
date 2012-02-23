class ApplicantsController < ApplicationController
  def index
  end

  def new
    #don't need to write anything here, since it creates (new+save) in the create action
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new( params[:applicant] )

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
