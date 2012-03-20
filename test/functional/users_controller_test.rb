require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end
  
  setup do
    @applicant = applicants(:good)
  end
  
  #the user is not logged in
  test "should get new" do
    get :new
    assert_response :success
  end
  
  #the creature is already logged in
  test "already logged in" do
    @request.session[:user_id] = users("one").id
    get :new
    assert_response :redirect
    assert_equal "#{users('one').email} is already logged in, Please Log out first", flash[:notice]
  end
  
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
    get :create, :id => @user.to_param
    assert_response :success
    end
    
   test "should show user" do
    @user.password="123qwe"
    get :show, :id => @user.id
    assert_response :success
   end
   #test "should show user" do
   #   @user.password="123qwe"
   #   get :show, :id => @user.to_param
   #   assert_response :success
   #   assert_template 'show'
   #   assert_not_nil assigns(:user)
   #   assert assigns(:user).valid?
   #   end
   
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
