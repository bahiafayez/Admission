require 'test_helper'

class CollegeTest < ActiveSupport::TestCase
  fixtures :colleges
  #if the student has been to other college these information should be filled
  # validates :name, :faculty, :major, :city, :country, :attended_from, :attended_to, :language, :gpa,
  test "college attributes can't be empty"do
    college=College.new
    assert college.invalid?
    assert college.errors[:name].any?
    assert college.errors[:faculty].any?
    assert college.errors[:major].any?
    assert college.errors[:city].any?
    assert college.errors[:country].any?
    assert college.errors[:attended_from].any?
    assert college.errors[:attended_to].any?
    assert college.errors[:language].any?
    assert college.errors[:gpa].any?
  
  end
  
  test "should create college" do
    college = College.new
    college = colleges(:good)
    assert college.save
  end

  test "should find college" do
    college_id = colleges(:good).id
    assert_nothing_raised { College.find(college_id) }
  end

  test "should update college" do
     college = colleges(:good)
     assert college.update_attributes(:major => 'new major')
  end
  
  test "should destroy college" do
    college = colleges(:good)
    college.destroy
    assert_raise(ActiveRecord::RecordNotFound) { College.find(college.id) }
  end
  
  test "college: gpa" do
    one = colleges(:one)                    
    one.gpa="G"
    assert one.invalid?,"Invalid GPA"
  end
  
  test "college: gpa range" do
    one = colleges(:one)                    
    assert one.invalid?,"Invalid GPA"
  end
  

end
