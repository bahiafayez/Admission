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
    mail to: user.email, subject: 'Registration complete', :cc => "bahia.sharkawy@gmail.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.submitted.subject
  #
  def submitted(user, email)
    @greeting = "Hi"
    @name = user.applicant.first_name
    mail to: user.email, subject: 'Application Submission Confirmation', :cc => "bahia.sharkawy@gmail.com"
    attachments["#{user.applicant.first_name}-Application.pdf"] = email
  end
  
  def email(user, to, subject, body)
    @greeting = "Dear #{user.applicant.first_name}"
    @name = user.applicant.first_name
    @body=body
    mail to: to, subject: subject, :cc => "bahia.sharkawy@gmail.com"
    
    #attachments["#{user.applicant.first_name}-Application.pdf"] = email
  end
  
  def batch_email(to, subject, body)
    @greeting = "Dear all,"
    @body=body
    mail subject: subject,:cc => "bahia.sharkawy@gmail.com", :bcc => to
    
    #attachments["#{user.applicant.first_name}-Application.pdf"] = email
  end
  
  def close_email(to)
    @greeting = "Dear all,"
    
    mail subject: "Admission Closed",:cc => "bahia.sharkawy@gmail.com", :bcc => to
    
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
    mail to: user.email, subject: 'Application Feedback', :cc => "bahia.sharkawy@gmail.com"
  end
  
  def close_user(user)
    mail to: user.email, subject: 'Application Closed', :cc => "bahia.sharkawy@gmail.com"
  end
end
