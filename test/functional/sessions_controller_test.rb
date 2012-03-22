require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:good)
  end
  
  #??
  test "should create user, but goes to new" do
    post :create, { :email => 'mail@gmail.com',:password =>'123qwe' }
   assert_equal "Invalid email or password1", flash[:notice]
  end
  
  
  test "sessions: already logged in" do
    @request.session[:user_id] = users("one").id
    get :new
    assert_response :redirect
    assert_equal "#{users('one').email} is already logged in, Please Log out first", flash[:notice]
  end
  
  
  test "should destroy sessions" do
    # we don't need to assert for count
    delete :destroy, :id => @user.to_param
    assert_response :redirect
    assert_redirected_to "/"

    assert_equal "Logged out!", flash[:notice]
    
    assert_raise(ActiveRecord::RecordNotFound) { User.find(@user.to_param) }

    end


end
