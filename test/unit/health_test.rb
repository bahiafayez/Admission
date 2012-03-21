require 'test_helper'

class HealthTest < ActiveSupport::TestCase
  test "Applicant must not be empty" do
    health = Health.new
    assert health.invalid?
    assert health.errors[:illness].any?
  
  end
end
