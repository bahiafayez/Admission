require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  test "User must not be empty" do
    user = User.new
    assert user.invalid?
    assert user.errors[:email].any?
    assert user.errors[:password].any?

   end
   
   test "users: password max length" do
    good = users(:good) 
    good.password= "123aaaaaaaaaaassssssssssssssssssssssssss111111111111111"           
    assert good.invalid?
    assert_equal "is too long (maximum is 40 characters)",good.errors[:password].join('; ')   
  end 
  
  test "users: password min length" do
    good = users(:good) 
    good.password= "1"           
    assert good.invalid?
    assert_equal "is too short (minimum is 6 characters)",good.errors[:password].join('; ')   
  end  
  
  test "user email must be valid" do
     one = users(:one) 
     assert one.invalid?
     assert_equal "Invalid E-mail",one.errors[:email].join('; ')
  end
  
  #test "user email unique" do
                         
  #   good= users(:good) 
  #   assert !good.save
  #   assert_equal 'email has already taken', good.errors[:email]
  #end
  
  
  
end
