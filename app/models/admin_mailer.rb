class AdminMailer < ActionMailer::Base
  default to: Proc.new {'laura@additiveanalytics.com'},
          from: 'support@additiveanalytics.com'
 
  def new_user_waiting_for_approval(user)
    @user = user
    mail(subject: "New User Signup: #{@user.email}")
  end
end
