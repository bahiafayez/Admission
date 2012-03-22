require 'test_helper'

class ApplicantsControllerTest < ActionController::TestCase
  fixtures :applicants 
  #test "should get index" do
  #  get :index
  #  assert_response :success
  #end

  #test "should get new" do
  #  get :new
  #  assert_response :success
  #end

   
   test "should get new,not pressing at button" do
    @request.session[:user_id] = users("good").id
    get(:new, {:flag => 'false'})
  
    assert_redirected_to root_path 
    assert_equal "redirected to root", flash[:notice]
   end

  test "should get new,pressing at button" do
    @request.session[:user_id] = users("good").id
    get(:new, {:flag => 'true'})
     assert_response :success
   end
  
  #test "should get create" do
  #  get :create
  #  assert_response :success
  #end
  #test "should create applicant" do
  #  assert_difference('Applicant.count') do
  #    post :create, applicant: applicants(:good)
  #  end
  #assert_redirected_to applicant_path(assigns(:applicant))
  #end
  
  #test "should create applicant" do
  #assert_difference('Applicant.count') do
  #  post :create, applicant: applicants(:good)  
  #end
  #assert_redirected_to applicant_path(assigns(:applicant))
  #assert_equal 'Applicant was successfully created.', flash[:notice]
  #end


  #test "should get destroy" do
  #  get :destroy
  #  assert_response :success
  #end

end
