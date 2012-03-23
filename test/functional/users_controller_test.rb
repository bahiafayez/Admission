require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end
  
  setup do
    @applicant = applicants(:good)
  end

#####################new################################# 
  #the user is not logged in
  test "should get new" do
     @request.session[:user_id] = nil
    get :new
    assert_response :success
  end
  
  #the creature is already logged in
  test "already logged in" do
    @request.session[:user_id] = users("good").id
    get :new
    assert_response :redirect
    assert_equal "#{users('good').email} is already logged in, Please Log out first", flash[:notice]
  end

####################create#############################
  #user signs up
  test "should create user" do
    get :create, :id => @user.to_param
    @request.session[:user_id] = users("one").id
    
    assert_difference('User.count') do
    post :create, :user => { :email => 'somemail@mail.com',:password =>'123bob' }
    end
    assert_response :redirect
     assert_equal "Signed up!", flash[:notice]
    end
    
   #user fails validation,goes to new? sucess?
   test "should create user:but he fails validation" do
    post :create, :id => @user.to_param
    assert_response :success

    
    end
   #######################user############################
   test "should show user(html)" do
    @user.password="123qwe"
    get :show, :format => 'html', :id =>@user.id
    assert_response :success
   end
   
   test "should show user(json)" do
    @user.password="123qwe"
    get :show, :format => 'json', :id =>@user.id
    assert_response :success
   end
   
   ######################application#################
   test "user don't have applicant" do  
      get :application, :id => @user.to_param
      assert_response :redirect
      assert_equal "no applicant", flash[:notice]
   end
   
   test "user has applicant" do  
      @user.applicant=@applicant
      get :application, :id => @user.to_param
      assert_response :redirect
      assert_equal "applicant exists", flash[:notice]
   end
end
