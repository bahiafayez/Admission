require 'test_helper'

class SecondarySchoolTest < ActiveSupport::TestCase
 
  fixtures :secondary_schools
  
    test "should create secondry school" do
    secondary_school = SecondarySchool.new
    secondary_school = secondary_schools(:good2)
    assert secondary_school.save
  end

  test "should find secondry school" do
    secondary_school_id = secondary_schools(:good).id
    assert_nothing_raised { SecondarySchool.find(secondary_school_id) }
  end

  test "should update secondry school" do
     secondary_school = secondary_schools(:good2)
     assert secondary_school.update_attributes(:name => 'name')
  end
  
  test "should destroy secondry school" do
    secondary_school = secondary_schools(:good)
    secondary_school.destroy
    assert_raise(ActiveRecord::RecordNotFound) { SecondarySchool.find(secondary_school.id) }
  end
  
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
                     
   good = secondary_schools(:good) 
            
    good.name=secondary_schools(:school1).name
    assert good.invalid?                    
    assert_equal "is too long (maximum is 20 characters)",good.errors[:name].join('; ') 
      
  end
   #####################address##########################
   test "secondry school: address length" do
                     
    good = secondary_schools(:good) 
            
    good.name=secondary_schools(:school1).address
    assert good.invalid?                    
    assert_equal "is too long (maximum is 20 characters)",good.errors[:name].join('; ') 
      
  end
  #######################language############################
 
   
  #######################school type####################################
  test "secondry school: school type" do
                         
    one = secondary_schools(:school1)        
    assert one.invalid?
    assert_equal "is not included in the list",one.errors[:school_type].join('; ')
  end
  
  test "secondry school: certificate type" do
                         
    one = secondary_schools(:school1)        
    assert one.invalid?
    assert_equal "is not included in the list",one.errors[:certificate_type].join('; ')
  end
end
