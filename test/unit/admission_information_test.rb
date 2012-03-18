require 'test_helper'

class AdmissionInformationTest < ActiveSupport::TestCase
  fixtures :admission_informations

  test "admission information attributes must not be empty" do
    admission_information = AdmissionInformation.new
   
    assert admission_information.invalid?
    
    assert admission_information.errors[:semester].any?
    #assert admission_information.errors[:applying_to].any?
    
    #intended major can be empty if undecided
    
    assert admission_information.errors[:intended_major].any?
    assert admission_information.errors[:toefl_test_results].any?
    assert admission_information.errors[:toefl_test_date].any?
    
    #assert admission_information.errors[:proficiency_test].any?
   
   end
  
  #####################semester###########################
  test "admission: semester" do
    info1 = AdmissionInformation.new
    info1.semester="Spring 2009"
    info1.applying_to="enginneering"
    info1.intended_major="enginneering"
    info1.toefl_test_results="600"
    info1.toefl_test_date="23-03-2010"
    assert info1.valid?, "#{info1.semester}s is not supposed to be from seclection"
  end 
  
  
  
  
  ######################applying_to#############################


  #test "admission info: invalid options of applying_to" do
  #  info1 = AdmissionInformation.new
  #  info1.semester="Spring 2009"
  #  info1.applying_to="Arts"
  #  info1.intended_major="enginneering"
  #  info1.toefl_test_results="600"
  #  info1.toefl_test_date="23-03-2010"
    #majors.each do |name|
    #info2.applying_to=name
  #  assert info1.valid?, "#{info1.applying_to} shouldn't be a valid major"
    #end
  #end
  
  #test "admission info applying_to should be only alphbats" do
  #  info1 = admission_informations(:info1)                     
  #  assert_match( /^[a-zA-Z]+$/, info1.applying_to, ["applying_to contains non alphabetical charchters"] )
  #end
  
  ######################intended major############################
 
  test "admission info intended major should be alphbats and" do
    info1 = admission_informations(:info1)
    info1.intended_major="999()i" 
    #Tests if Regexp does match a given String.                 
    assert_match( /^[a-zA-Z]+$/, info1.intended_major, ["intended_major contains non alphabetical charchters"] )
  end
 
 ####################toefl_test_results################################ 
  test "admission info toefl results should be numbers" do
    info1 = admission_informations(:info1)
    
    #Tests if Regexp does match a given String.                 
    assert_match( /[a-zA-Z]+$/, info1.toefl_test_results, ["toefl_test_results contains alphabetical charchters"] )
  end
  ####################toefl date#################################
  test "admision toefl_test_date" do
    info2 = admission_informations(:info2)
    info2.toefl_test_date="date1"
    assert info2.invalid?                      
    assert_equal "can't be blank; is not a valid date",info2.errors[:toefl_test_date].join('; ')
  end
end