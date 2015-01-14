class UserMailer < ActionMailer::Base
  default from: "noreply@gmail.com"

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: "Password_reset")
  end
end
