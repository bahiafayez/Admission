require 'test_helper'

class AddressTest < ActiveSupport::TestCase
   fixtures :addresses
   
    
   test "address: attributes must not be empty" do
    address = Address.new
    assert address.invalid?
    assert address.errors[:address].any?
    #assert address.errors[:email].any?
    
    #check if an error assiocated with individual input if empty
    assert address.errors[:telephone].any?
    
    #check if an error assiocated with individual input if empty
    assert address.errors[:mobile].any?
    
    #fax is not a must
    #assert address.errors[:fax].any?
    
    assert address.errors[:address_type].any?
   end
  #######################address##########################3
  #test "address: address length" do
                     
  #  address2 = addresses(:address2)          
  #  if address2.address.length>100
  #    flunk("Address more than 100 charchters")
  #  end
      
  #end
  
  #######################email##########################3
  #test "address: email format" do
  #  address = addresses(:one) 
  #  address.email="bob"                    
  #  assert address.invalid?
  #  assert_equal "Invalid E-mail",address.errors[:email].join('; ')
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
  #test "address: phone format" do
  #  one = addresses(:one)          
  #  one.telephone="b"
  #  one.invalid?                
  #  assert one.invalid?
  #  assert_equal "Invalid Number",one.errors[:telephone].join('; ')
  #end
  
  #test "address: phone length" do
  #  one = addresses(:one)          
  #  one.telephone="13623463128725823"               
  #  assert one.invalid?
  #  assert_equal "Invalid Number",one.errors[:telephone].join('; ')
  #end
  ########################mobile#################################
  #test "address: mobile format" do
    
  #  one = addresses(:one)          
  #  one.mobile="b"
  #  assert one.invalid?
  #  assert_equal "Invalid Number",one.errors[:mobile].join('; ')
  #end
  
  #test "address: mobile length" do
                     
  #  one = addresses(:one)          
  #  one.mobile="124125132612631361"               
  #  assert one.invalid?
  #  assert_equal "Invalid Number",one.errors[:mobile].join('; ')
  #end
  
  #########################fax###############################
  #test "address: fax format" do
  #  one = addresses(:one)          
  #  one.fax="b"
                
  #  assert one.invalid?
  #  assert_equal "Invalid Number",one.errors[:fax].join('; ')
  #end
  
  #test "address: fax length" do
          
  #  one = addresses(:one)          
  #  one.fax="212315412632609324760970176"               
  #  assert one.invalid?
  #  assert_equal "Invalid Number",one.errors[:fax].join('; ')
  #end
  ##########################address type######################################
  #test "address type" do
    
  #  address2 = addresses(:address2)         
  #  address2.address_type="clinic"
  #  assert address2.invalid?
  #  assert_equal "is not included in the list", address2.errors[:address_type].join('; ')
  #end 
  ####################################################################### 

  
end
