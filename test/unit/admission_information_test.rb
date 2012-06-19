require 'test_helper'

class AdmissionInformationTest < ActiveSupport::TestCase
  fixtures :admission_informations

  test "should create admission_information" do
    admission_information = AdmissionInformation.new
    admission_information = admission_informations(:good)
    assert admission_information.save
  end

  test "should find admission_information" do
    admission_information_id = admission_informations(:good).id
    assert_nothing_raised { AdmissionInformation.find(admission_information_id) }
  end

  test "should update admission_information" do
     admission_information = admission_informations(:good)
     assert admission_information.update_attributes(:major_id => 3 )
  end
  
  test "should destroy admission_information" do
    admission_information = admission_informations(:good)
    admission_information.destroy
    assert_raise(ActiveRecord::RecordNotFound) { AdmissionInformation.find(admission_information.id) }
  end

test "admission information attributes must not be empty" do
    admission_information = AdmissionInformation.new
   
    assert admission_information.invalid?
    
    assert admission_information.errors[:semester_id].any?
    assert admission_information.errors[:school_id].any?
    assert admission_information.errors[:major_id].any?
    assert admission_information.errors[:toefl_test_results].any?
    assert admission_information.errors[:toefl_test_date].any?
    
   
   end
  
  
  
  
  ######################intended major############################
 
  # test "admission info intended major should be alphbats" do
    # info1 = admission_informations(:info1)
    # assert info1.invalid?
    # assert_equal "intended_major contains non alphabetical characters",info1.errors[:intended_major].join('; ')
  # end
 
 ####################toefl_test_results################################ 
  test "admission info toefl results should be numbers" do
    info1 = admission_informations(:info1)
    assert info1.invalid?
    assert_equal "Invalid Number",info1.errors[:toefl_test_results].join('; ')

  end

end