class UsersController < ApplicationController
  #skip_before_filter :authorize
  before_filter :correct_user2, :only => [:show, :application]
  
  # def new
    # @user = User.new
    # if session[:user_id]!= nil
      # @existing=User.find(session[:user_id])
      # redirect_to @existing , notice: "#{@existing.email} is already logged in, Please Log out first"
    # end
  # end
  
  

  # def create
    # @user = User.new(params[:user])
    # if @user.save
      # session[:user_id] = @user.id  #to save in session..
      # ApplicationNotifier.created(@user).deliver
      # redirect_to @user, :notice => "Signed up!"
    # else
      # render "new"
    # end
  # end

  
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  def move
    redirect_to user_path(:id => current_user.id)
  end
  
  def application  #ADJUST THIS!!!!   
    @user = User.find(params[:id])
    if Semester.where(:status => true).count>0 and School.where(:status => true).count>0
      if @user.applicant == nil
        flash[:flag]=true
        redirect_to new_applicant_url
      else
        redirect_to @user.applicant,:notice => "applicant exists"
      end
    else
       redirect_to @user, :notice => "Admission Closed"
    end
    
  end
  
end
