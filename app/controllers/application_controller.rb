class ApplicationController < ActionController::Base
  protect_from_forgery
 # before_filter :authorize
  #somthing
  #blabla
  #something else
 # helper_method :current_user  #to make it available in the view.. i think an alternative would be to implement it in the application_helper directly..

 # private

  def current_user?(user)
    user == current_user
  end
#   
  # def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  
#  protected
    
  # def authorize
    # unless User.find_by_id(session[:user_id])
      # redirect_to log_in_url, notice: "Please Log in"
    # end
  # end
#   
  def correct_user
      @app = Applicant.find(params[:id])
      @user = @app.user
      redirect_to(root_path) unless current_user?(@user)
  end
  
  def correct_user2
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end

  rescue_from CanCan::AccessDenied do |exception|
      redirect_to admin_dashboard_path, :alert => exception.message
    end

    def current_ability
      @current_ability ||= Ability.new(current_admin_user)
    end
end
