class Notifier < ActionMailer::Base
  default from: "athuan255@gmail.com"

  def sent_mail(user)
    @user = user
    attachments["#{user.display_name}.xls"] = File.read("app/assets/excels/#{user.display_name}.xls")
    mail(to: user.email, subject: "Information about salary")
  end
  
end
