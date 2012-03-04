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
    mail to: user.email, subject: 'Application Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.submitted.subject
  #
  def submitted(applicant)
    @greeting = "Hi"

    mail to: user.email, subject: 'Application Submission Confirmation'
  end
end
