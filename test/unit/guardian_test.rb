require 'test_helper'

class GuardianTest < ActiveSupport::TestCase
  
  fixtures :guardians
  
  test "should create guardian" do
    guardian = Guardian.new
    guardian = guardians(:good2)
    guardian.email="validemail@email.com"
    assert guardian.save
  end

  test "should find guardian" do
    guardian_id = guardians(:good).id
    assert_nothing_raised { Guardian.find(guardian_id) }
  end

  test "should update guardian" do
     guardian = guardians(:good2)
     guardian.email="validemail@email.com"
     assert guardian.update_attributes(:first_name => 'any')
  end
  
  test "should destroy guardian" do
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
  test "guardian: address length" do
                     
    good = guardians(:guardian2)        
    assert good.invalid?                    
    assert_equal "is too long (maximum is 100 characters)",good.errors[:address].join('; ') 
      
  end
  
  #############################telephone##########################################
  test "is guardian's phone valid?" do
                     
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
                     
    assert @guardian2.invalid?
    assert_equal "Invalid Number",@guardian2.errors[:mobile].join('; ')
  end
  
  test "mobile must exist if phone empty" do
    good = guardians(:good)           
    good.telephone=nil
    good.mobile=nil
    assert good.invalid?                      
    assert_equal "can't be blank", good.errors[:mobile].join('; ')
  end
   ##############################occupation##############################################
  test "business occupation should be alphbats" do
    assert @guardian1.invalid?                              
    assert_equal "occupation contains non alphabetical characters",@guardian1.errors[:occupation].join('; ')
  end
  
  ######################business telephone###################################
  test "business telephone valid" do
    assert @guardian2.invalid?
    assert_equal "Invalid Number",@guardian2.errors[:business_telephone].join('; ')
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
    good = guardians(:good) 
    good.business_address= guardians(:guardian2).business_address           
    assert good.invalid?
    assert_equal "is too long (maximum is 100 characters)",good.errors[:business_address].join('; ')   
  end  
  
  test "applicant's financial status should be yes or no" do
    good = guardians(:badFinancial)          
    assert good.invalid?
    assert_equal "is not included in the list",good.errors[:financial].join('; ')                     
  end
end
