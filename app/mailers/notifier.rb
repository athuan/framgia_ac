class Notifier < ActionMailer::Base
  default from: "athuan255@gmail.com"

  def sent_mail(user)
    @user = user
    attachments["#{user.uid}.xls"] = File.read("app/assets/excels/#{user.uid}.xls")
    mail(to: user.email, subject: "Infomation about salary")
  end
  
end
