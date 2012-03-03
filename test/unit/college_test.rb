require 'test_helper'

class CollegeTest < ActiveSupport::TestCase
  fixtures :colleges
  #if the student has been to other college these infromation should be filled
  test "college attributes can't be empty"do
    college=College.new
    assert college.invalid?
    assert college.errors[:name].any?,"name"
    assert college.errors[:faculty].any?,"Faculty"
    assert college.errors[:major].any?,"major"
    assert college.errors[:city].any?,"city"
    assert college.errors[:country].any?"country"
    assert college.errors[:attended_from].any?,"attended from"
    assert college.errors[:attended_to].any?"attended to"
    assert college.errors[:language].any?"lang"
    assert college.errors[:gpa].any?"gpa"
  
  end
  
  test "college: gpa" do
    one = colleges(:one)                    
    one.gpa="G"
    assert one.invalid?,"Invalid GPA"
  end
  
  test "college: gpa range" do
    one = colleges(:one)                    
    one.gpa=7
    assert one.invalid?,"Invalid GPA"
  end
  
  test "college: attended_from" do
    one = colleges(:one)
    one.attended_from="date1"
    assert one.invalid?                      
    assert_equal "is not a valid date",one.errors[:attended_from].join('; ')
  end
  
  test "college: attended_to" do
    one = colleges(:one)
    one.attended_to="date1"
    assert one.invalid?                      
    assert_equal "is not a valid date",one.errors[:attended_to].join('; ')
  end
end
