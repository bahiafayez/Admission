require 'test_helper'

class SecondarySchoolTest < ActiveSupport::TestCase
 
  fixtures :secondary_schools
  test "SecondarySchool: attributes must not be empty" do
    secondary_school = SecondarySchool.new
    assert secondary_school.invalid?
    assert secondary_school.errors[:name].any?
    assert secondary_school.errors[:address].any?
    assert secondary_school.errors[:language].any?
    assert secondary_school.errors[:attended_from].any?
    assert secondary_school.errors[:attended_to].any?
    assert secondary_school.errors[:school_type].any?
       
   end
   #####################name##########################
   test "secondry school: name length" do
                     
   one = secondary_schools(:one)          
    one.name="Egypt 2020 Egypt 2020 Egypt 2020 Egypt 2020"
    if one.name.length>20
      flunk("Address more than 20 charchters")
    end
      
  end
   #####################address##########################
   test "secondry school: address length" do
                     
   three = secondary_schools(:three)          
    if three.address.length>100
      flunk("Address more than 100 charchters")
    end
      
  end
  #######################language############################
  test "secondry school: language" do
                         
    one = secondary_schools(:one)          
    one.language="spanglish"
    assert one.valid?, "can't be valid,#{one.language} is not a valid language"
  end
   ########################attended_from#############################
    test "school: attended_from" do
    one = secondary_schools(:one)
    one.attended_from="date1"
    assert one.invalid?                      
    assert_equal "can't be blank; is not a valid date",one.errors[:attended_from].join('; ')
  end
  ########################attended_to#############################
  test "schole: attended_to" do
    one = secondary_schools(:one)
    one.attended_to="date1"
    assert one.invalid?                      
    assert_equal "can't be blank; is not a valid date",one.errors[:attended_to].join('; ')
  end
  #######################school type####################################
  test "secondry school: school type" do
                         
    one = secondary_schools(:one)          
    one.school_type="undetermined"
    assert one.valid?, "can't be valid,#{one.school_type} is not a valid school type"
  end
end
