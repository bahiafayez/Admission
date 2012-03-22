require 'test_helper'

class ApplicantTest < ActiveSupport::TestCase
  
  fixtures :applicants    
  setup do  
      @applicant = applicants(:person)  
  end                        
  
  setup do  
      @applicant2 = applicants(:person2)  
  end  
  
  test "should create applicant" do
    applicant = Applicant.new
    applicant = applicants(:good)
    #applicant.passport_number="123gjhg32"
    #applicant.national_id="123456564"
    #applicant.transportation="Private"
    assert applicant.save
  end

  test "should find applicant" do
    applicant_id = applicants(:person).id
    assert_nothing_raised { Applicant.find(applicant_id) }
  end

  test "should update applicant" do
     applicant = applicants(:good)
     assert applicant.update_attributes(:first_name => 'Donald')
  end
  
  test "should destroy applicant" do
    applicant = applicants(:person)
    applicant.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Applicant.find(applicant.id) }
  end


  test "Applicant must not be empty" do
    applicant = Applicant.new
    applicant.military_status=""
    assert applicant.invalid?
    assert_equal ["can't be blank", "first name contains non alphabetical characters"], applicant.errors[:first_name]
    assert_equal ["can't be blank", "middle name contains non alphabetical characters"], applicant.errors[:middle_name]
    assert_equal ["can't be blank", "last name contains non alphabetical characters"], applicant.errors[:last_name]
    assert_equal ["can't be blank"], applicant.errors[:date_of_birth]
    assert_equal ["can't be blank", "Place of Birth contains non alphabetical characters"], applicant.errors[:place_of_birth]
    assert_equal ["can't be blank","is not included in the list"], applicant.errors[:gender]
    assert_equal ["can't be blank","is not included in the list"], applicant.errors[:transportation]
    assert_equal ["can't be blank","is not included in the list"], applicant.errors[:military_status]

  end

  
  ###############################first name##########################################
  
  test "applicant first name should be alphbats" do
                         
    assert @applicant.invalid?
    assert_equal "first name contains non alphabetical characters",@applicant.errors[:first_name].join('; ')
  end
  
  
  ###############################middle name##########################################
  test "applicant middle name should be alphbats" do
                         
    assert @applicant.invalid?
    assert_equal "middle name contains non alphabetical characters",@applicant.errors[:middle_name].join('; ')
  end
  ################################last name#########################################
  test "applicant last name should be alphbats and no spaces" do
                         
    assert @applicant.invalid?
    assert_equal "last name contains non alphabetical characters",@applicant.errors[:last_name].join('; ')
  end
  
 
  ##############################place of birth################################
  test "applicant's place of birth should be a valid place" do
                         
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
  
   test "applicant is not valid without a unique national id" do
    
    one = applicants(:one)          
    assert one.invalid?
    assert_equal "National ID has already been taken", one.errors[:national_id].join('; ')
  end
  
  test "applicant national id must exist if passport empty" do
    good = applicants(:good)           
    good.national_id=nil
    good.passport_number=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:national_id].join('; ')
  end
  
  #########################national id expiry date##############################
  #test "applicant national id expiry date of birth" do
  #  assert @applicant.invalid?                      
  #  assert_equal "Invalid date",@applicant.errors[:national_id_expiry_date].join('; ')
  #end
  
  test "applicant national exipry date must exist if national id present" do
    good = applicants(:good)           
    good.national_id_expiry_date=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:national_id_expiry_date].join('; ')
  end
  
  test "applicant national id must exist if passport number empty" do
    good = applicants(:good)           
    good.national_id=nil
    good.passport_number=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:passport_number].join('; ')
  end
  #########################passport number##############################
  test "applicant passport number should be valid" do
     assert @applicant.invalid?
     assert_equal "Invalid Number",@applicant.errors[:passport_number].join('; ')
  end
  

  test "applicant is not valid without a unique passport number" do
    
    one = applicants(:one)          
    one.passport_number="18971"
    assert one.invalid?
    assert_equal "Passport Number has already been taken", one.errors[:passport_number].join('; ')
  end
  
  test "applicant passport must exist if national id empty" do
    good = applicants(:good)           
    good.national_id=nil
    good.passport_number=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:passport_number].join('; ')
  end
  
  test "applicant passport expiry date must exist if passport exists" do
    good = applicants(:good)           
    good.passport_expiry_date=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:passport_expiry_date].join('; ')
  end
  
  test "applicant country of issunace must exist if passport exists" do
    good = applicants(:good)           
    good.country_of_issuance=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:country_of_issuance].join('; ')
  end
  ######################################country of issuance#############################################
  test "applicant's country of issuance should be a valid place" do
    assert @applicant.invalid?
    assert_equal "is not included in the list",@applicant.errors[:country_of_issuance].join('; ')                     
  end
  ######################################passport expiry###############################################
   #test "applicant passport expiry valid?" do

  #  assert @applicant2.invalid?                     
  #  assert_equal "Invalid Date",@applicant2.errors[:passport_expiry_date].join('; ')
  #end
  
  
  #################################transportation########################################
  
  test "applicant's transportation" do
    
    assert @applicant2.invalid?
    assert_equal "is not included in the list", @applicant2.errors[:transportation].join('; ')
  end 
  
  
  


  
end
