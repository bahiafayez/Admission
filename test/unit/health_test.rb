require 'test_helper'

class HealthTest < ActiveSupport::TestCase
  fixtures :healths
  test "illness must not be empty" do
    health = Health.new
    assert health.invalid?
    assert health.errors[:illness].any?
  
  end
  
  test "health: illness must valid" do
    health=healths(:bad)
    
    assert health.invalid?
    assert_equal "Invalid illness",health.errors[:illness].join('; ')
  
  end
  
  test "health: description must valid" do
    health=healths(:bad)
    assert health.invalid?
    assert_equal "Invalid description",health.errors[:description].join('; ')
  
  end
  
  test "health: description length" do
                     
    health=healths(:two)
    assert health.invalid?                    
    assert_equal "is too long (maximum is 100 characters)",health.errors[:description].join('; ') 
      
  end
  
end
