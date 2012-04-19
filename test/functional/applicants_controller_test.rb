require 'test_helper'

class ApplicantsControllerTest < ActionController::TestCase
  fixtures :applicants 
   #setup do
    #@user=User.new
    #@user.email="good@gmail.com"
    #@user.password="123qwe"
    #@user.password_confirmation="123qwe"
    #@user.save
  #end
  
 
########################new##########################
  # test "should get new,not pressing at button" do
   
  #   sign_in @user 
  #  @request.session[:user_id] =@user.id
    #session[:user_id] =@user.id
  #  get(:new,  nil, nil,{:flag => false})
  
  #  assert_redirected_to root_path 
  #  assert_equal "redirected to root", flash[:notice]
  # end

 #test "should get new,pressing at button" do
 #   sign_in @user
 #   @request.session[:user_id] = @user.id
    #session[:user_id] = @user.id
 #   get(:new,nil, nil,{:flag => true})

 #   assert_response :success

 #  end
  
  #########################create############################
  
  # test "should get create" do
     # #post :create, applicant: @user.applicant
     # #call new first
#      
      # # user=User.new
      # # user.email="good1@gmail.com"
      # # user.password="12q3qwe"
      # # user.password_confirmation="12q3qwe"
# #       
      # # user.applicant=user.build_applicant
      # # user.applicant.healths.build
      # # user.applicant.secondary_schools.build 
      # # user.applicant.works.build
      # # user.applicant.colleges.build
    # # #2.times do
# #     
    # # #end
# #    
    # # 2.times do
      # # user.applicant.addresses.build
      # # user.applicant.guardians.build
# #       
    # # end
# #     
    # # user.applicant.admission_information= AdmissionInformation.new
    # # user.applicant.attachment = Attachment.new
    # # user.applicant.uni_related_info = UniRelatedInfo.new
# #     
    # # user.applicant.uni_related_info.uni_choice= UniChoice.new
    # # user.applicant.uni_related_info.other_choice= OtherChoice.new
# #       
    # # user.save 
#     
    # #get(:new,nil, nil,{:flag => true})
#     
    # @user.build_applicant
    # @user.applicant.healths.build
    # @user.applicant.secondary_schools.build 
    # @user.applicant.works.build
    # @user.applicant.colleges.build
    # 2.times do
       # @user.applicant.addresses.build
       # @user.applicant.guardians.build
#       
     # end
#      
    # @user.applicant.admission_information= AdmissionInformation.new
    # @user.applicant.attachment = Attachment.new
    # @user.applicant.uni_related_info = UniRelatedInfo.new
# #     
    # @user.applicant.uni_related_info.uni_choice= UniChoice.new
    # @user.applicant.uni_related_info.other_choice= OtherChoice.new
    # @user.applicant.save(:validate => false)
    # @user.save
    # @request.session[:user_id] = @user.id  
    # post(:create, {:id => @user.applicant.to_param})
#      
    # assert_response :redirect
    # assert_equal 'Applicant was successfully created.', flash[:notice]
# 
# 
# 
  # end
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
