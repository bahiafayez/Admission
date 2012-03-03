require 'test_helper'

class WorkTest < ActiveSupport::TestCase
    fixtures :works
    test "work must not be empty" do

      work = Work.new
      assert work.invalid?
      assert work.errors[:employer].any?
      assert work.errors[:worked_from].any?
      assert work.errors[:worked_to].any?
      assert work.errors[:tasks].any?
    end
    
   test "work: attended_from" do
    one = works(:one)
    one.worked_from="date1"
    assert one.invalid?                      
    assert_equal "is not a valid date",one.errors[:worked_from].join('; ')
  end
  
  test "work: attended_to" do
    one = works(:one)
    one.worked_from="date1"
    assert one.invalid?                      
    assert_equal "is not a valid date",one.errors[:worked_from].join('; ')
  end
  
  #######################tasks##########################3
  test "work: tasks length" do
                     
    one = works(:one)          
    if one.tasks.length>500
      flunk("tasks more than 500 charchters")
    end
      
  end
  ####################employer#######################
   test "work: employer name length" do
                     
   one = works(:one)          
    one.employer="Nile university Nile university Nile university"
    if one.employer.length>30
      flunk("employer more than 30 charchters")
    end
      
  end
end
