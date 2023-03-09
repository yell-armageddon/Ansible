class UserMailer < ActionMailer::Base
#  default from: "drettstadt@gmail.com"
 default from: "yell@gmx.de"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation

  end

  def password_reset(user)
 	@user = user
#	mail(to: @user.email, subject: "Password reset")
    mail to: user.email, subject: "Password reset"

  end
end
