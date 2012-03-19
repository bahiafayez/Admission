require 'test_helper'

class GuardianTest < ActiveSupport::TestCase
  
  fixtures :guardians
  
  test "should create guradian" do
    guardian = Guardian.new
    guardian = guardians(:good)
    assert guardian.save
  end

  test "should find guradian" do
    guardian_id = guardians(:good).id
    assert_nothing_raised { Guardian.find(guardian_id) }
  end

  test "should update guradian" do
     guardian = guardians(:good)
     assert guardian.update_attributes(:first_name => 'any')
  end
  
  test "should destroy guradian" do
    guardian = guardians(:good)
    guardian.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Guardian.find(guardian.id) }
  end
  
  
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
    assert guardian.errors[:last_name].any?
    assert guardian.errors[:address].any?
    assert guardian.errors[:occupation].any?
   end
  
  
  ###############################first name##########################################
  
  test "address first name should be alphbats" do
    assert @guardian2.invalid?
    assert_equal "first name contains non alphabetical characters",@guardian2.errors[:first_name].join('; ')
  end
  ###############################middle name##########################################
  test "address middle name should be alphbats" do
    assert @guardian2.invalid?
    assert_equal "middle name contains non alphabetical characters",@guardian2.errors[:middle_name].join('; ')
  end
  ################################last name#########################################
  test "address last name should be alphbats and no spaces" do
     assert @guardian2.invalid?
    assert_equal "last name contains non alphabetical characters",@guardian2.errors[:last_name].join('; ')

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
                     
    assert @guardian1.invalid?
    assert_equal "Invalid Number",@guardian1.errors[:telephone].join('; ')
  end
  
  test "phone must exist if mobile empty" do
    good = guardians(:good)           
    good.telephone=nil
    good.mobile=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:mobile].join('; ')
  end
  #############################mobile##########################################
  test "is mobile format valid?" do
                     
    assert @guardian1.invalid?
    assert_equal "Invalid Number",@guardian1.errors[:mobile].join('; ')
  end
  
  test "mobile must exist if phone empty" do
    good = guardians(:good)           
    good.telephone=nil
    good.mobile=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:phone].join('; ')
  end
   ##############################occupation##############################################
  test "business occupation should be alphbats" do
                                  
    assert_equal "Invalid Number",@guardian1.errors[:ocupation].join('; ')
  end
  
  ######################business telephone###################################
  test "business telephone valid" do
    assert @guardian1.invalid?
    assert_equal "Invalid Number",@guardian1.errors[:business_telephone].join('; ')
  end
  
  test "business phone must exist if email empty" do
    good = guardians(:good)           
    good.business_telephone=nil
    good.email=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:business_telephone].join('; ')
  end
  ######################fax###################################
  test "is fax format valid?" do
    assert @guardian1.invalid?
    assert_equal "Invalid Number",@guardian1.errors[:fax].join('; ')
  end
  
  
  ######################email###################################
  test "address: is email valid" do
    assert @guardian1.invalid?
    assert_equal "Invalid E-mail",@guardian1.errors[:email].join('; ')
  end
  
   test "business phone can be empty if email exist" do
    good = guardians(:good)           
    good.business_telephone=nil
    good.email=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:business_telephone].join('; ')
  end
  #####################business_address################################## 
  test "address: business_address length" do
                     
              
    if @guardian2.business_address.length>100
      flunk("Address more than 100 charchters")
    end   
  end  
  
  test "applicant's country of issuance should be a valid place" do
    good = guardians(:good)          
    good.financial="anything"
    assert_equal "is not included in the list",good.errors[:financial].join('; ')                     
  end
end
