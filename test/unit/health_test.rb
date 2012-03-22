require 'test_helper'

class HealthTest < ActiveSupport::TestCase
  test "illness must not be empty" do
    health = Health.new
    assert health.invalid?
    assert health.errors[:illness].any?
  
  end
  
  test "illness must valid" do
    health = Health.new
    health.illness="1221G"
    assert health.invalid?
    assert_equal "Invalid illness",health.errors[:illness].join('; ')
  
  end
end
