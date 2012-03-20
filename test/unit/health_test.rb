require 'test_helper'

class HealthTest < ActiveSupport::TestCase
  test "Applicant must not be empty" do
    applicant = Health.new
    assert applicant.invalid?
    assert secondary_school.errors[:illness].any?
  
  end
end
