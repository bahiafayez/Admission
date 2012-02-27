class UsersController < ApplicationController
  skip_before_filter :authorize
  
  def new
    @user = User.new
  end
  
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  def application  #ADJUST THIS!!!!   
    @user = User.find(session[:user_id])
    if @user.applicant == nil
      redirect_to new_applicant_url
    else
      redirect_to @user.applicant
    end
  end
  
end
