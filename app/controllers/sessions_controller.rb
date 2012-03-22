class SessionsController < ApplicationController
  #skip_before_filter :authorize
  
  def new
    #won't create a user, since over there using form_tag, don't need a resource,
    #instead will save stuff in params, and use it in create
    if session[:user_id]!= nil
      @existing=User.find(session[:user_id])
      redirect_to @existing , notice: "#{@existing.email} is already logged in, Please Log out first"
    end
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id  #to save in session..
      redirect_to user, :notice => "Thanks for signing in, "
    else
      flash.alert = "Invalid Email or Password" #flash because i won't use redirect.. (so can't set in redirect)
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
