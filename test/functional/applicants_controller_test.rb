require 'test_helper'

class ApplicantsControllerTest < ActionController::TestCase
  fixtures :applicants 
   setup do
    @user=User.new
    @user.email="good@gmail.com"
    @user.password="123qwe"
    @user.password_confirmation="123qwe"
    @user.save
    @applicant=applicants(:good)
    #@applicant.healths=healths(:)
    # @applicant.secondary_schools.new(:) 
    # @applicant.works.build
    # @applicant.colleges.build
    # @applicant.addresses.build
    # @applicant.guardians.build
    # @applicant.admission_information= AdmissionInformation.new
    # @applicant.attachment = Attachment.new
    @applicant.uni_related_info = UniRelatedInfo.new
#     
    # @applicant.uni_related_info.uni_choice= UniChoice.new
    # @applicant.uni_related_info.other_choice= OtherChoice.new
    @applicant.uni_related_info.uni_choice= UniChoice.new
    @applicant.uni_related_info.other_choice= OtherChoice.new
    @user.applicant=@applicant
   
  end
  
 
########################new##########################
   test "should get new,not pressing at button" do
    session[:user_id] =@user.id
    get(:new,  nil, nil,{:flag => false})
  
    assert_redirected_to root_path 
    assert_equal "redirected to root", flash[:notice]
   end

 test "should get new,pressing at button" do
    session[:user_id] = @user.id
    get(:new,nil, nil,{:flag => true})

    assert_redirected_to '/applicants/new/'

   end
  
  #########################create############################
  
  test "should get create" do
     #post :create, applicant: @user.applicant
     #call new first
     
    session[:user_id] = @user.id
      
    assert_difference('Applicant.count') do
      post :create, product: @applicant
    end

    assert_redirected_to applicant_path(assigns(:applicant))
    
    # #@user.applicant.save(:validate => false)
    # get(:create, {:applicant_id => @user.applicant.id}) 
    # assert_response :redirect
    # assert_equal 'Applicant was successfully created.', flash[:notice]
  end
  ######################################################
  
  #test "should edit saved applicant" do
  #  @applicant.status=""
  #  @user.applicant=@applicant
  #  @request.session[:user_id] = @user.id 
    #sign_in  @user
    #Authorization.current_user = @user
  #  get :edit, :id => @applicant.to_param
    #@request.session[:user_id] = @user.id 
  #  assert_redirected_to @applicant
  #  assert_equal "Sorry Application Already Submitted", flash[:notice]
    #Authorization.current_user = nil'
  #end
  
  
  #test "should update saved applicant" do
   
  #  @user.applicant=@applicant
  #  @request.session[:user_id] = @user.id 
  # get :update, :id => @applicant.to_param
  #  assert_response :redirect
  #end
  
  
  #test "should get create" do
  #  get :create
  #  assert_response :success
  #end
  #test "should create applicant" do
  #  assert_difference('Applicant.count') do
  #    post :create, applicant: @applicant
  #  end
  #assert_redirected_to applicant_path(assigns(:applicant))
  #end
  
  #test "should create applicant" do
  #assert_difference('Applicant.count') do
  #  post :create, applicant: applicants(:good)  
  #end
  #assert_redirected_to applicant_path(assigns(:applicant))
  #assert_equal 'Applicant was successfully created.', flash[:notice]
  #
  #end


  #test "should get destroy" do
  #  get :destroy
  #  assert_response :success
  #end
 
end
