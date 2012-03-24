require 'test_helper'
#############
class AddressTest < ActiveSupport::TestCase
   fixtures :addresses
   
   test "should create address" do
    address = Address.new
    address = addresses(:good)
    assert address.save
  end

  test "should find address" do
    address_id = addresses(:good).id
    assert_nothing_raised { Address.find(address_id) }
  end

  test "should update address" do
     address = addresses(:good)
     assert address.update_attributes(:address => 'Donald home')
  end
  
  test "should destroy address" do
    address = addresses(:good)
    address.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Address.find(address.id) }
  end
  
   test "address: attributes must not be empty" do
    address = Address.new
    assert address.invalid?
    assert address.errors[:address].any?
    assert address.errors[:address_type].any?
   end
  #######################address##########################3
  
  test "address: address length" do
                     
    address2 = addresses(:bad)
    assert address2.invalid?                    
    assert_equal "is too long (maximum is 100 characters)",address2.errors[:address].join('; ') 
      
  end
  
  #######################email##########################3
  #test "address: email format" do
  #  address = addresses(:one) 
  #  address.email="bob"                    
  #  assert address.invalid?
  #   assert_equal "Invalid E-mail",address.errors[:email].join('; ')
  #end
  
  #test "address: email should be unique" do
  #  address1 = addresses(:address1)
  #  assert !address1.save
  #  assert_equal "email has already taken", address1.errors[:email][0]
  #end
  
  #test "address: email should not be case sensative" do
  #  address2 = addresses(:address2)                    
  #  assert address2.invalid?,"mail should not be case sensative"
  #end
  ######################phone############################### 
  
  test "address: telephone must exist if mobile empty" do
    good = addresses(:good)           
    good.telephone=nil
    good.mobile=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:telephone].join('; ')
  end
  test "address: phone format" do
    one = addresses(:address)                      
    assert one.invalid?
    assert_equal "Invalid Number",one.errors[:telephone].join('; ')
  end
  
  test "address: phone length" do
    one = addresses(:address2) 
    one.telephone="212315412632609324760970176"                      
    assert one.invalid?
    assert_equal "is too long (maximum is 20 characters)",one.errors[:telephone].join('; ')
  end
  ########################mobile#################################
  test "address: mobile format" do
    
    one = addresses(:address)          
    assert one.invalid?
    assert_equal "Invalid Number",one.errors[:mobile].join('; ')
  end
  
  test "address: mobile length" do
                     
    one = addresses(:address2)
    one.mobile="212315412632609324760970176"
    assert one.invalid?
    assert_equal "is too long (maximum is 20 characters)",one.errors[:mobile].join('; ')
  end
  
  test "address: mobile must exist if telephone empty" do
    good = addresses(:good)           
    good.telephone=nil
    good.mobile=nil
    assert good.invalid?                      
    assert_equal "can't be blank",good.errors[:mobile].join('; ')
  end
  #########################fax###############################
  test "address: fax format" do
    one = addresses(:address)              
    assert one.invalid?
    assert_equal "Invalid Number",one.errors[:fax].join('; ')
  end
  
  test "address: fax length" do
          
    one = addresses(:address2)          
    one.fax="212315412632609324760970176"               
    assert one.invalid?
    assert_equal "is too long (maximum is 20 characters)",one.errors[:fax].join('; ')
  end
  ##########################address type######################################
  test "address type" do
    
    address2 = addresses(:good)         
    address2.address_type="clinic"
    assert address2.invalid?
    assert_equal "is not included in the list", address2.errors[:address_type].join('; ')
  end 
  ####################################################################### 

  
end
