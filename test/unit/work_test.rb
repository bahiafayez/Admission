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
    

  #######################tasks##########################3
  test "work: tasks length" do
                     
    one = works(:one)          
    assert one.invalid?                    
    assert_equal "is too long (maximum is 500 characters)",one.errors[:tasks].join('; ')
      
  end
  ####################employer#######################
   test "work: employer name length" do
                     
   one = works(:one)          
    one.employer="Nile university Nile university Nile university"
     assert one.invalid?                    
      assert_equal "is too long (maximum is 30 characters)",one.errors[:employer].join('; ')
   end   
end
