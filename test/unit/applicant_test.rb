require 'test_helper'

class ApplicantTest < ActiveSupport::TestCase
  
  fixtures :applicants    
  setup do  
      @applicant = applicants(:person)  
  end                        
  
  setup do  
      @applicant2 = applicants(:person2)  
  end  
  
  test "Applicant attributes must not be empty" do
    applicant = Applicant.new
    assert applicant.invalid?
   #:first_name, :middle_name,:last_name,:date_of_birth, :place_of_birth, :gender,:military_status, :national_id, :national_id_expiry_date, :passport_number, :country_of_issuance, :passport_expiry_date, :transportation
   #validates :first_name, :middle_name,:last_name,:date_of_birth, :place_of_birth, :gender,:military_status, :transportation,  :presence => true

   assert applicant.errors[:first_name].any?
   assert applicant.errors[:middle_name].any?
   assert applicant.errors[:last_name].any?
   assert applicant.errors[:date_of_birth].any?
   assert applicant.errors[:place_of_birth].any?
   assert applicant.errors[:gender].any?
   assert applicant.errors[:transportation].any?
   assert applicant.errors[:military_status].any?,"military status empty"
  end
  
  ###############################first name##########################################
  
  test "applicant first name should be alphbats" do
                         
    assert_match( /^[a-zA-Z]+$/, @applicant.first_name, ["first name contains non alphabetical charchters"] )
  end
  
  
  ###############################middle name##########################################
  test "applicant middle name should be alphbats" do
                         
    assert_match( /^[a-zA-Z]+$/, @applicant.middle_name, ["middle name contains non alphabetical charchters"] )
  end
  ################################last name#########################################
  test "applicant last name should be alphbats and no spaces" do
                         
    assert_match( /^[a-zA-Z]+$/, @applicant.last_name, ["last name contains non alphabetical charchters"] )
  end
  ##############################date of birth###########################
  #should i keep now that we use dropdown
  #test "applicant date of birth validity" do
    
  #  assert @applicant.invalid?
  #  assert_equal "Invalid Date",@applicant.errors[:date_of_birth].join('; ')
  #end
  ##############################place of birth################################
  test "applicant's place of birth should be a valid place" do
                         
    #@assert @applicant.invalid?
    #assert_equal "applicant's place of birth is not valid",@applicant.errors[:place_of_birth].join('; ')
     assert @applicant.invalid?
    assert_equal "Invalid Place",@applicant.errors[:place_of_birth].join('; ')
  end
  ##############################gender#################################
  test "applicant's gender" do
    
    assert @applicant.invalid?
    assert_equal "is not included in the list",@applicant.errors[:gender].join('; ')
  end
  ######################military status########################
  test "applicant's military status" do
    
 
    assert @applicant.invalid?
    assert_equal "is not included in the list",@applicant.errors[:military_status].join('; ')
  end 
  ############################national id###################################
  test "applicant national id should be a postive" do
    

    assert @applicant.invalid?
    assert_equal "Invalid Number",@applicant.errors[:national_id].join('; ')
  end
  
  # test "applicant is not valid without a unique national id" do
    
  #  one = applicants(:one)          
  #  one.national_id="11298"
  #  assert one.invalid?
  #  assert_equal "National ID has already taken", one.errors[:national_id].join('; ')
  #end
  #########################national id expiry date##############################
  #test "applicant national id expiry date of birth" do
  #  assert @applicant.invalid?                      
  #  assert_equal "Invalid date",@applicant.errors[:national_id_expiry_date].join('; ')
  #end
  
  #########################passport number##############################
  test "applicant passport number should be a postive number" do
     assert @applicant.invalid?
     assert_equal "Invalid Number",@applicant.errors[:passport_number].join('; ')
  end
  

  test "applicant is not valid without a unique passport number" do
    
    one = applicants(:one)          
    one.passport_number="18971"
    assert one.invalid?
    assert_equal "has already been taken", one.errors[:passport_number].join('; ')
  end
  ######################################country of issuance#############################################
  test "applicant's country of issuance should be a valid place" do
    assert @applicant.invalid?
    assert_equal "Invalid Country",@applicant.errors[:country_of_issuance].join('; ')                     
  end
  ######################################passport expirt###############################################
  #test "applicant passport expiry date of birth" do
    #applicant = applicants(:one)
    #applicant.passport_expiry_date="date1"
  #  assert @applicant2.invalid?                     
  #  assert_equal "can't be blank; Invalid Date",@applicant2.errors[:passport_expiry_date].join('; ')
  #end
  
  
  #################################transportation########################################
  
  test "applicant's transportation" do
    
    assert @applicant2.invalid?
    assert_equal "is not included in the list", @applicant2.errors[:transportation].join('; ')
  end 
  
  
  #test "image type test" do
  #  ok = %w{ image.gif image.jpg image.png image.eps image.svg }
  #  bad = %w{ image.gif image.eps image.png image.svg }
  #  ok.each do |name|
  #    assert new_product(name).valid?, "#{name} shouldn't be invalid"
  #  end
  #  bad.each do |name|
  #    assert new_product(name).invalid?, "#{name} shouldn't be valid"
  #  end
  #end

  
end
