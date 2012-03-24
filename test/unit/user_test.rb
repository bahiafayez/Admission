require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  test "User must not be empty" do
    user = User.new
    assert user.invalid?
    assert user.errors[:email].any?
    assert user.errors[:password].any?

   end
   
   test "should create user" do
    user = User.new
    user.email="goodemail2@mail.com"
    user.password="password"
    user.password_confirmation="password"
    #user = users(:good2)
    assert user.save
  end

  test "should find user" do
    user_id = users(:good).id
    assert_nothing_raised { User.find(user_id) }
  end

  test "should update user" do
     user = User.new
     user.email="goodemail2@mail.com"
     user.password="password"
     user.password_confirmation="password"
     user.save
     assert user.update_attributes(:email => 'Donald@mail.com')
  end
  
  test "should destroy user" do
    user = users(:good)
    user.destroy
    assert_raise(ActiveRecord::RecordNotFound) { User.find(user.id) }
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
  
  
  test "user email must be unique" do
    
    one = users(:good1) 
    assert one.invalid?
    assert_equal "Email has already taken", one.errors[:email].join('; ')
  end
  
  
  
end
