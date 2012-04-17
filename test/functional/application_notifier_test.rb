require 'test_helper'

class ApplicationNotifierTest < ActionMailer::TestCase
   setup do
    @user = users(:good)
  end
  
  setup do
    @applicant = applicants(:good)
  end
  
  #test "created" do
  #  @applicant.status="Just Created"
    
  #  @user.applicant=@applicant
      
  #  mail = ApplicationNotifier.created(@user)
    #assert_equal "Created", mail.subject
    #assert_equal ["to@example.org"], mail.to
    #assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  #  @expected.from    = "Nile University <admission.nileu@gmail.com>"
  #  @expected.to      = 'good@mail.com'
  #  @expected.subject = 'Application Confirmation'
  #  assert_equal @expected.from, mail.from
  #  assert_equal @expected.to, mail.to
  #  assert_equal @expected.subject, mail.subject
    #assert_equal @expected.body.encoded, mail.body.encoded
  #end
  
  #test "submitted" do
  #  @applicant.status="submmited"
    
   # @user.applicant=@applicant
      
   # mail = ApplicationNotifier.submitted(@user,@user.email)
   # #assert_equal "Created", mail.subject
   # #assert_equal ["to@example.org"], mail.to
   # #assert_equal ["from@example.com"], mail.from
   # #assert_match "Hi", mail.body.encoded
   # @expected.from    = "Nile University <admission.nileu@gmail.com>"
   # @expected.to      = 'good@mail.com'
   # @expected.subject = 'Application Submission Confirmation'
   # assert_equal @expected.from, mail.from
   # assert_equal @expected.to, mail.to
   # assert_equal @expected.subject, mail.subject
    #assert_equal @expected.body.encoded, mail.body.encoded
  #end
  
  #test "Approved" do
  #  @applicant.status="Approved"
    
  #  @user.applicant=@applicant
      
  #  mail = ApplicationNotifier.reason(@user)
    #assert_equal "Created", mail.subject
    #assert_equal ["to@example.org"], mail.to
    #assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  #  @expected.from    = "Nile University <admission.nileu@gmail.com>"
  #  @expected.to      = 'good@mail.com'
  #  @expected.subject = 'Application Feedback'
  #  assert_equal @expected.from, mail.from
  #  assert_equal @expected.to, mail.to
  #  assert_equal @expected.subject, mail.subject
    #assert_equal @expected.body.encoded, mail.body.encoded
  #end
  #test "submitted" do
    #mail = ApplicationNotifier.submitted
    #assert_equal "Submitted", mail.subject
    #assert_equal ["to@example.org"], mail.to
   # assert_equal ["from@example.com"], mail.from
  #  assert_match "Hi", mail.body.encoded
  #end

end
