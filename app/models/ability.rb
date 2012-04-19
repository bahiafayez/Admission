# app/models/admin_ability.rb

# All back end users (i.e. Active Admin users) are authorized using this class
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new

    # We operate with three role levels:
    # #  - Editor
    # #  - Moderator
    # #  - Manager
# 
    # # An editor can do the following:
    # can :manage, :all
    # can :read, SomeOtherModel
# 
    # # A moderator can do the following:
    # if user.role?('moderator')
      # can :manage, SomeOtherModel
    # end
# 
    # # A manager can do the following:
    # if user.role?('manager')
      # can :manage, SomeThirdModel
    # end
    case user.role   
      when "Admission"
        can :manage, :all
        cannot :batch_email2, Applicant
      when "Finance"
        can :read, Applicant, :status => "Approved" 
        can :batch_email2, Applicant
        can :send_batch_email2, Applicant
        can :email, Applicant
        can :sendemail, Applicant
        #cannot :manage, Dashboard  
        #cannot [:destroy,:edit], Post 
      when "Library"
        can :read, Applicant, :status => "Approved"
        can :batch_email2, Applicant
        can :send_batch_email2, Applicant
        can :email, Applicant
        can :sendemail, Applicant
        #cannot :closeapp, Applicant 
      when "IT"
        can :read, Applicant, :status => "Approved"
        can :batch_email2, Applicant
        can :send_batch_email2, Applicant
        can :email, Applicant
        can :sendemail, Applicant 
      when "Coordinator"
        can :read, Applicant, :status => "Approved"
        can :batch_email2, Applicant
        can :send_batch_email2, Applicant
        can :email, Applicant
        can :sendemail, Applicant  
      end
  end
end