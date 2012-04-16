require 'test_helper'

class UserTest < ActionDispatch::IntegrationTest
   setup do
    @user=User.create!(:email => "ryan@example.com", :password => "secret")
   
   
     
  end
   
   
   test "user:logging in with invalid username and password" do
    user = users(:one)
    visit 'users/sign_in'
    fill_in 'email', :with=> user.email#"ryan@example.com"
    fill_in "Password", :with =>user.password #"secret"
    click_button "Sign in"
  
    assert_contain "Invalid email or password"
    
    assert_equal('/users/sign_in', current_url)
    

  end
  
  test "user:logging in with valid username and password" do
    visit 'users/sign_in'
    fill_in 'email', :with=> "ryan@example.com"
    fill_in "Password", :with =>"secret"
    click_button "Sign in"
    follow_redirect!  
    assert_equal("http://example.org/user_root", last_request.url)
    visit last_request.url
    assert_contain "Application"
  end
  
  test "application but admission closed" do
    visit 'users/sign_in'
    fill_in 'email', :with=> "ryan@example.com"
    fill_in "Password", :with =>"secret"
    click_button "Sign in"
    follow_redirect!  
    visit last_request.url
    #assert_contain "You are being redirected."
   click_link "Application"
   assert_contain "Admission Closed"
  end
  
   test "application but admission open" do
     semester=Semester.create!(:name => "winter2011", :status=> true)
    visit 'users/sign_in'
    fill_in 'email', :with=> "ryan@example.com"
    fill_in "Password", :with =>"secret"
    click_button "Sign in"
    follow_redirect!  
    visit last_request.url
    #assert_contain "You are being redirected."
   click_link "Application"
   assert_contain "New Application"
  end
  
  test "application but admission open and there is applicant" do
     semester=Semester.create!(:name => "winter2011", :status=> true)
    visit 'users/sign_in'
    fill_in 'email', :with=> "ryan@example.com"
    fill_in "Password", :with =>"secret"
    click_button "Sign in"
    follow_redirect!  
    visit last_request.url
    #assert_contain "You are being redirected."
   click_link "Application"
   assert_contain "New Application"
     click_button "save"
  end
  test "application but admission open and applicant there" do
      #applicant.save(:validate => false)
  #   @user.applicant=applicant
      semester=Semester.create!(:name => "winter2011", :status=> true)
      visit 'users/sign_in'
      fill_in 'email', :with=> "ryan@example.com"
      fill_in "Password", :with =>"secret"
     click_button "Sign in"
     follow_redirect!  
     visit last_request.url

     click_link "Application"
      click_button "save"
      follow_redirect!  
      assert_contain "Applicant was successfully created" 
   end
  
   test "application but admission open (edit)" do
       semester=Semester.create!(:name => "winter2011", :status=> true)
      visit 'users/sign_in'
      fill_in 'email', :with=> "ryan@example.com"
      fill_in "Password", :with =>"secret"
     click_button "Sign in"
     follow_redirect!  
     visit last_request.url

     click_link "Application"
      click_button "save"
      follow_redirect!  
      assert_contain "Applicant was successfully created" 
      click_link "Edit Application"
      assert_contain "Editing Applicant"
       click_button "save"
   end

end
