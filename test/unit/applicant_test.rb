require 'test_helper'

class ApplicantTest < ActiveSupport::TestCase
  
  fixtures :applicants    
 
  
  test "Applicant attributes must not be empty" do
  applicant = Applicant.new
  assert applicant.invalid?
 
  assert applicant.errors[:first_name].any?
  assert applicant.errors[:middle_name].any?
  assert applicant.errors[:last_name].any?
  assert applicant.errors[:date_of_birth].any?
  assert applicant.errors[:place_of_birth].any?
  assert applicant.errors[:gender].any?
  assert applicant.errors[:military_status].any?
  assert applicant.errors[:national_id].any?
  assert applicant.errors[:national_id_expiry_date].any?
  assert applicant.errors[:passport_number].any?
  assert applicant.errors[:country_of_issuance].any?
  assert applicant.errors[:passport_expiry_date].any?
  assert applicant.errors[:transportation].any?
  end
  
  test "applicant name should be alphbats" do
    applicant = Applicant.new(first_name:applicants(:person).first_name,
                              middle_name:applicants(:person).middle_name,
                              last_name:applicants(:person).last_name,
                              date_of_birth:applicants(:person).date_of_birth,
                              place_of_birth:applicants(:person).place_of_birth,
                              gender:applicants(:person).gender,
                              national_id:applicants(:person).national_id,
                              national_id_expiry_date:applicants(:person).national_id_expiry_date,
                              passport_number:applicants(:person).passport_number,
                              country_of_issuance:applicants(:person).country_of_issuance,
                              passport_expiry_date:applicants(:person).passport_expiry_date,
                              transportation:applicants(:person).transportation)
                            
    assert_match( /^[a-z,A-Z]/, applicant.first_name, ["name contains non alphabetical charchters"] )
  end
  
  test "applicant national id should be a postive number" do
    applicant = Applicant.new(first_name:applicants(:person).first_name,
                              middle_name:applicants(:person).middle_name,
                              last_name:applicants(:person).last_name,
                              date_of_birth:applicants(:person).date_of_birth,
                              place_of_birth:applicants(:person).place_of_birth,
                              gender:applicants(:person).gender,
                              national_id:applicants(:person).national_id,
                              national_id_expiry_date:applicants(:person).national_id_expiry_date,
                              passport_number:applicants(:person).passport_number,
                              country_of_issuance:applicants(:person).country_of_issuance,
                              passport_expiry_date:applicants(:person).passport_expiry_date,
                              transportation:applicants(:person).transportation)
                            
    applicant.national_id = "-1000"
    assert applicant.valid?,"(1)must be postive and not equal 0"
   
  end
  
  test "applicant is not valid without a unique passport number" do
    applicant = Applicant.new(first_name: applicants(:person).first_name,
                              middle_name: applicants(:person).middle_name,
                              last_name: applicants(:person).last_name,
                              date_of_birth: applicants(:person).date_of_birth,
                              place_of_birth: applicants(:person).place_of_birth,
                              gender: applicants(:person).gender,
                              national_id: applicants(:person).national_id,
                              national_id_expiry_date: applicants(:person).national_id_expiry_date,
                              passport_number: applicants(:person).passport_number,
                              country_of_issuance: applicants(:person).country_of_issuance,
                              passport_expiry_date: applicants(:person).passport_expiry_date,
                              transportation: applicants(:person).transportation)
                    
    assert !applicant.save
    assert_equal "passport number has already been taken", applicant.errors[:passport_number].join('; ')

  end

end
