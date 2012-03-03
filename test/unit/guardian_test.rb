require 'test_helper'

class GuardianTest < ActiveSupport::TestCase
  
  fixtures :guardians
  setup do  
      @guardian1 = guardians(:guardian1)  
   end 
  
  setup do  
      @guardian2 = guardians(:guardian2)  
   end 
  test "guardian attributes must not be empty" do
    guardian = Guardian.new
   
    assert guardian.invalid?
    assert guardian.errors[:first_name].any?
    #assert guardian.errors[:middle_name].any?
    assert guardian.errors[:last_name].any?
    assert guardian.errors[:address].any?
    assert guardian.errors[:telephone].any?
    assert guardian.errors[:mobile].any?
    assert guardian.errors[:occupation].any?
    assert guardian.errors[:company_name].any?
    assert guardian.errors[:business_telephone].any?
    assert guardian.errors[:email].any?
    assert guardian.errors[:fax].any?
    assert guardian.errors[:business_address].any?
   end
  
  
  ###############################first name##########################################
  
  test "address first name should be alphbats" do
    guardian1 = guardians(:guardian1)                       
    guardian1.first_name="-As"
    assert_match( /^[a-zA-Z]+$/, guardian1.first_name, ["first name contains non alphabetical charchters"] )
  end
  ###############################middle name##########################################
  test "address middle name should be alphbats" do
    guardian1 = guardians(:guardian1)                       
    guardian1.middle_name="-john"                     
    assert_match( /^[a-zA-Z]+$/, guardian1.middle_name, ["middle name contains non alphabetical charchters"] )
  end
  ################################last name#########################################
  test "address last name should be alphbats and no spaces" do
    guardian1 = guardians(:guardian1)                       
    guardian1.last_name="122jack"                     
    assert_match( /^[a-zA-Z]+$/, guardian1.last_name, ["last name contains non alphabetical charchters"] )
  end
  ##############################address##############################################
  test "address: address length" do
                     
   guardian = guardians(:guardian2)            
    if guardian.address.length>100
      flunk("Address more than 100 charchters")
    end
      
  end
  
  #############################telephone##########################################
  test "is guradian's phone valid?" do
                     
    guardian1 = guardians(:guardian1)
    guardian1.telephone="-A123"
    assert_match( /[a-zA-Z]+$/, guardian1.telephone, ["phone contains alphabetical charchters"] )
  end
  #############################mobile##########################################
  test "is mobile format valid?" do
                     
    guardian1 = guardians(:guardian1)
    guardian1.mobile="-A123" 
    assert_match( /[a-zA-Z]+$/, guardian1.mobile, ["mobile contains alphabetical charchters"] )
  end
  
   ##############################occupation##############################################
  test "business occupation should be alphbats" do
    guardian1 = guardians(:guardian1)                       
    guardian1.occupation="122doctor"                     
    assert_match( /^[a-zA-Z]+$/, guardian1.occupation, ["address contains non alphabetical charchters"] )
  end
  
  ######################business telephone###################################
  test "business telephone valid" do
    guardian1 = guardians(:guardian1)
    guardian1.business_telephone="-A123"                 
    assert_match( /[a-zA-Z]+$/, guardian1.business_telephone, ["business phone contains alphabetical charchters"] )
  end
  
  ######################fax###################################
  test "is fax format valid?" do
    guardian1 = guardians(:guardian1)
    guardian1.fax="-A123"                 
    assert_match( /^[a-zA-Z]+$/, guardian1.fax, ["fax contains alphabetical charchters"] )
  end
  
  
  ######################email###################################
  test "address: is email valid" do
    guardian1 = guardians(:guardian1)
    guardian1.email="nomail"                 
    assert guardian1.invalid?
    assert_equal "Invalid E-mail",guardian1.errors[:email].join('; ')
  end
  
  #####################business_address################################## 
  test "address: business_address length" do
                     
   guardian = guardians(:guardian2)            
    if guardian.business_address.length>100
      flunk("Address more than 100 charchters")
    end   
  end  

end
