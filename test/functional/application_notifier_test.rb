require 'test_helper'

class ApplicationNotifierTest < ActionMailer::TestCase
   setup do
    @user = users(:one)
  end
  
  setup do
    @applicant = applicants(:good)
  end
  
  test "created" do
    @user.applicant=@applicant
      
    #mail = ApplicationNotifier.created
    #assert_equal "Created", mail.subject
    #assert_equal ["to@example.org"], mail.to
    #assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
    mail = ApplicationNotifier.created(@user)
    @expected.from    = "Nile University <admission.nileu@gmail.com>"
    @expected.to      = 'good@mail.com'
    @expected.subject = 'Application Confirmation'
    assert_equal @expected.encoded, mail.body.encoded
  end

  #test "submitted" do
    #mail = ApplicationNotifier.submitted
    #assert_equal "Submitted", mail.subject
    #assert_equal ["to@example.org"], mail.to
   # assert_equal ["from@example.com"], mail.from
  #  assert_match "Hi", mail.body.encoded
  #end

end
