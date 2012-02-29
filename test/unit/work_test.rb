require 'test_helper'

class WorkTest < ActiveSupport::TestCase
    test "work must not be empty" do

    work = Work.new
    assert work.invalid?
    assert work.errors[:employer].any?
    assert work.errors[:worked_from].any?
    assert work.errors[:worked_to].any?
    assert work.errors[:tasks].any?
    end
end
