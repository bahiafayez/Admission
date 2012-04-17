require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end
  
  setup do
    @applicant = applicants(:good)
    #@semester=Semester.create!(:name => "winter2011", :status=> true)
  end
  
  setup do
    @user1=User.new
    @user1.email="good@gmail.com"
    @user1.password="123qwe"
    @user1.password_confirmation="123qwe"
    @user1.save
    

   #@user1.applicant=@applicant
   # @user1.save
    
  end
#####################new#################################
  #the user is not logged in
  #test "should get new" do
   # :authenticate
   # get :new
   # assert_response :success
  #end
  
  #the creature is already logged in
  #test "already logged in" do
    #@request.session[:user_id] = @user1.id
    #get :new
    #assert_response :redirect
    #assert_equal "#{@user1.email} is already logged in, Please Log out first", flash[:notice]
  #end

####################create#############################
  #user signs up
  #test "should create user" do
    
   # assert_difference('User.count') do
   # post :create, :user => { :email => 'somemail@mail.com',:password =>'123bob' }
   # end
   # assert_response :redirect
   # assert_equal "Signed up!", flash[:notice]
   # end
    
   #user fails validation,goes to new? sucess?
   #test "should create user:but he fails validation" do
   # post :create, :user => { :email => 'somemail',:password =>'12ob' }
   # assert_response :success
   # assert_equal "Not signed up!", flash[:notice]
   # end
   #######################user############################
   
   test "should show user(html)" do
    sign_in @user1

    get :show, :format => 'html', :id =>@user1.id
    assert_response :success
   end
   
   test "should show user(json)" do
    # #@user.password="123qwe"
    sign_in @user1
    get :show, :format => 'json', :id =>@user1.id
    assert_response :success
   end
   
   ######################application#################
   test "user don't have applicant" do
     
    semester=Semester.create!(:name => "winter2011", :status=> true)
     sign_in @user1
     get :application, :id => @user1.to_param
      assert_response :redirect
       #assert_equal "no applicant", flash[:notice]
   end
   
   test "user has applicant" do
      
      @user1.build_applicant(@applicant.attributes)
      @user1.save(:validate => false)
      semester=Semester.create!(:name => "winter2011", :status=> true)
     sign_in @user1
      get :application, :id => @user1.to_param
       assert_response :redirect
      assert_equal "applicant exists", flash[:notice]
   end
   
   test "user has applicant and the semesters are closed" do
      
    
      @user1.build_applicant(@applicant.attributes)
      @user1.save(:validate => false)
      sign_in @user1
      
      get :application, :id => @user1.to_param
       assert_response :redirect
      assert_equal "Admission Closed", flash[:notice]
   end
   
   test "user: move" do
      sign_in @user1
      get :move
      assert_response :redirect
      
   end
end



