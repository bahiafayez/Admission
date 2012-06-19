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
     school=School.create!(:name => "abc", :status => true)
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
     program= School.create!(:name => "abc", :status=> true)
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
      school=School.create!(:name => "abc", :status => true)
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
       school=School.create!(:name => "abc", :status => true)
      visit 'users/sign_in'
      fill_in 'email', :with=> "ryan@example.com"
      fill_in "Password", :with =>"secret"
     click_button "Sign in"
     follow_redirect!  
     visit last_request.url

     click_link "Application"
      click_button "Save"
      follow_redirect!  
      assert_contain "Applicant was successfully created" 
      click_link "Edit Application"
      assert_contain "Editing Applicant"
       click_button "Save"
   end
   
   test "application but admission open (fill)" do
       semester=Semester.create!(:name => "winter2011", :status=> true)
       program=School.create!(:name => "prog", :status=> true)
        applicant=applicants(:good)
        address=addresses(:good)
        admission_info=admission_informations(:good)
        guardian=guardians(:good)
        secondaryschool=secondary_schools(:good)
       
        college=colleges(:good)
        visit 'users/sign_in'
      fill_in 'email', :with=> "ryan@example.com"
      fill_in "Password", :with =>"secret"
      click_button "Sign in"
      follow_redirect!  
      visit last_request.url
   
      click_link "Application"
       assert_contain "New Application"
       #first_name: Mohamed
       #middle_name: Mohamed
        #last_name: Yassen       #validates :first_name, :middle_name,:last_name,:date_of_birth, :place_of_birth, :gender,:military_status, :transportation, :presence => true
        fill_in 'Middle Name', :with=> applicant.middle_name
        fill_in 'Last Name', :with=> applicant.last_name
        fill_in 'National ID', :with=> "8375"
        fill_in 'Passport number', :with=> "989123"
        
        select "1988", :from => "applicant_date_of_birth_1i"
        select "March", :from => "applicant_date_of_birth_2i"
        select "2", :from => "applicant_date_of_birth_3i"
        select "2012", :from => "applicant_national_id_expiry_date_1i"
        select "June", :from => "applicant_national_id_expiry_date_2i"
        select "2", :from => "applicant_national_id_expiry_date_3i"
        select "Egypt", :from => "Country of issuance" 
        select "2012", :from => "applicant_passport_expiry_date_1i"
        select "June", :from => "applicant_passport_expiry_date_2i"
        select "2", :from => "applicant_passport_expiry_date_3i" 
        #fill_in 'Date of birth', :with=> applicant.date_of_birth
        fill_in 'Place of birth', :with=> "Cairo, Egypt"
        fill_in 'Gender', :with=> applicant.gender
        fill_in 'Military status', :with=> applicant.military_status
        fill_in 'Transportation', :with=> applicant.transportation
        
        #fill_in 'Place of birth', :with=> applicant.place_of_birth
        #fill_in 'Gender', :with=> applicant.gender
        #fill_in 'Military status', :with=> applicant.military_status
        #fill_in 'Transportation', :with=> applicant.transportation
        
        fill_in 'applicant_addresses_attributes_0_address', :with=> address.address
        select "Both", :from => "applicant_addresses_attributes_0_address_type"
        fill_in 'applicant_addresses_attributes_0_telephone', :with=> address.telephone
         fill_in 'applicant_addresses_attributes_1_mobile', :with=> address.mobile
        fill_in 'applicant_addresses_attributes_1_address', :with=> address.address
        select "Both", :from => "applicant_addresses_attributes_1_address_type"
        fill_in 'applicant_addresses_attributes_1_telephone', :with=> address.telephone
         fill_in 'applicant_addresses_attributes_1_mobile', :with=> address.mobile
       
       
       select "winter2011", :from => "applicant_admission_information_attributes_semester_id"
        
        select "prog", :from => "applicant_admission_information_attributes_school_id"
        fill_in 'Toefl test results', :with=> admission_info.toefl_test_results
        
        select "2010", :from => "applicant_admission_information_attributes_toefl_test_date_1i"
        select "June", :from => "applicant_admission_information_attributes_toefl_test_date_2i"
        select "2", :from => "applicant_admission_information_attributes_toefl_test_date_3i"
        
        fill_in 'applicant_guardians_attributes_0_first_name', :with=>guardian.first_name
        fill_in 'applicant_guardians_attributes_0_last_name', :with=> guardian.last_name
        fill_in 'applicant_guardians_attributes_0_occupation', :with=>guardian.occupation
        fill_in 'applicant_guardians_attributes_0_address', :with=>guardian.address
         fill_in 'applicant_guardians_attributes_0_telephone', :with=>guardian.telephone
        fill_in 'applicant_guardians_attributes_0_mobile', :with=>guardian.mobile
         fill_in 'applicant_guardians_attributes_0_business_telephone', :with=>guardian.telephone
         fill_in 'applicant_guardians_attributes_0_email', :with=>"email@email.com"
        select "Yes", :from => "applicant_guardians_attributes_0_financial"
        
        fill_in 'applicant_guardians_attributes_1_first_name', :with=>guardian.first_name
        fill_in 'applicant_guardians_attributes_1_last_name', :with=> guardian.last_name
        fill_in 'applicant_guardians_attributes_1_telephone', :with=>guardian.telephone
        fill_in 'applicant_guardians_attributes_1_mobile', :with=>guardian.mobile
        fill_in 'applicant_guardians_attributes_1_occupation', :with=>guardian.occupation
        fill_in 'applicant_guardians_attributes_1_address', :with=>guardian.address
        fill_in 'applicant_guardians_attributes_1_business_telephone', :with=>guardian.telephone
         fill_in 'applicant_guardians_attributes_1_email', :with=>"email1@email.com"
        select "Yes", :from => "applicant_guardians_attributes_1_financial"
        
        fill_in 'applicant_secondary_schools_attributes_0_name', :with=>secondaryschool.name
        fill_in 'applicant_secondary_schools_attributes_0_address', :with=>secondaryschool.address
        select "English", :from =>"applicant_secondary_schools_attributes_0_language"
        
        select "2005", :from => "applicant_secondary_schools_attributes_0_attended_from_1i"
        select "March", :from => "applicant_secondary_schools_attributes_0_attended_from_2i"
        select "2", :from => "applicant_secondary_schools_attributes_0_attended_from_3i"
        
        select "2008", :from => "applicant_secondary_schools_attributes_0_attended_to_1i"
        select "March", :from => "applicant_secondary_schools_attributes_0_attended_to_2i"
        select "3", :from => "applicant_secondary_schools_attributes_0_attended_to_3i"
        select "2008", :from => "applicant_secondary_schools_attributes_0_graduation_date_1i"
        select "March", :from => "applicant_secondary_schools_attributes_0_graduation_date_2i"
        select "30", :from => "applicant_secondary_schools_attributes_0_graduation_date_3i"
        
        select "IG", :from => "applicant_secondary_schools_attributes_0_certificate_type"
        select "Private", :from =>"applicant_secondary_schools_attributes_0_school_type"
        
        fill_in 'applicant_colleges_attributes_0_name',:with=>college.name
        fill_in 'applicant_colleges_attributes_0_faculty',:with=>college.faculty
        fill_in 'applicant_colleges_attributes_0_major',:with=>college.major
        fill_in 'applicant_colleges_attributes_0_city',:with=>college.city
        select "Egypt", :from =>"applicant_colleges_attributes_0_country"
        
        
        select "2008", :from => "applicant_colleges_attributes_0_attended_from_1i"
        select "March", :from => "applicant_colleges_attributes_0_attended_from_2i"
        select "2", :from => "applicant_colleges_attributes_0_attended_from_3i"
        
        select "2009", :from => "applicant_colleges_attributes_0_attended_to_1i"
        select "March", :from => "applicant_colleges_attributes_0_attended_to_2i"
        select "3", :from => "applicant_colleges_attributes_0_attended_to_3i"
        
        select "English", :from =>"applicant_colleges_attributes_0_language"
        fill_in 'applicant_colleges_attributes_0_gpa',:with=>college.gpa
        
        fill_in 'applicant_healths_attributes_0_illness',:with=>"fever"
        
       
        fill_in "Employer", :with=>"IT"
        fill_in "tasks", :with=>:"IT"
        
        select "2010", :from => "applicant_works_attributes_0_worked_from_1i"
        select "March", :from => "applicant_works_attributes_0_worked_from_2i"
        select "2", :from => "applicant_works_attributes_0_worked_from_3i"
        select "2010", :from => "applicant_works_attributes_0_worked_to_1i"
        select "April", :from => "applicant_works_attributes_0_worked_to_2i"
        select "2", :from => "applicant_works_attributes_0_worked_to_3i"
        click_button "submit"
        #oops u didn't fill the first name
        assert_contain "You've got some validation errors" 
        fill_in 'First Name', :with=> applicant.first_name
        
        click_button "Save & Continue"
        #click_button "submit"
        assert_contain "You are being redirected."
        follow_redirect!
        assert_contain " Editing Applicant"
        click_button "Save"
        assert_contain "You are being redirected."
        follow_redirect!
        click_link "Edit Application"
        #assert_contain "You are being redirected."
        #follow_redirect!
        assert_contain " Editing Applicant"
        click_button "submit"
        assert_contain "You are being redirected."
        follow_redirect!
        click_link "Sign Out"
        assert_contain "You are being redirected."
        follow_redirect!
        #follow_redirect!
        #click_link "Edit Application"
        #assert_contain "Editing Applicant"
        #click_button "Save & Continue" 
        #follow_redirect!
        #click_button "Save"
        #follow_redirect!
        #click_link "Sign Out"
        #assert_contain "You are being redirected."
        #assert_contain "You've got some validation errors" 
   end
end
