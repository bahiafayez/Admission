class ApplicationNotifier < ActionMailer::Base
  default from: "Nile University <admission.nileu@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.created.subject
  #
  def created(user)
    @greeting = "Hi"
    logger.debug "In created METHOD!!!!"
    @user = user
    mail to: user.email, subject: 'Application Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.submitted.subject
  #
  def submitted(user, email)
    @greeting = "Hi"
    @name = user.applicant.first_name
    mail to: user.email, subject: 'Application Submission Confirmation'
    attachments["#{user.applicant.first_name}-Application.pdf"] = email
  end
  
  def email(user, subject, body)
    @greeting = "Dear #{user.applicant.first_name}"
    @name = user.applicant.first_name
    @body=body
    mail to: user.email, subject: subject
    
    #attachments["#{user.applicant.first_name}-Application.pdf"] = email
  end
  
  def reason(user)
    #@greeting = "Hi"
    if user.applicant.status== "Approved"
      @result="accepted"
      @greeting="Congratulations on your acceptance"
    else
      @result="rejected"
      @greeting="We're sorry, but you were rejected."
    end
    
    if user.applicant.notes!="" and user.applicant.notes!=nil
      @notes="Extra notes: #{user.applicant.notes}"
    end
    mail to: user.email, subject: 'Application Feedback'
  end
end
