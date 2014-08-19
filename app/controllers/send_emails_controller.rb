class SendEmailsController < ApplicationController

  def create
    @uid = params[:uid]
    salary_report_id = params[:salary_report_id]
    user = User.find_by(uid: @uid)
    Notifier.delay.sent_mail(user)
    SalaryReport.find(salary_report_id).sent_users.find_by(uid: @uid).update_attributes(sent: true)
    respond_to do |format|
      format.html { redirect_to salary_report_path(salary_report_id) }
      format.js
    end
  end

  def show
    respond_to do |format|
      format.csv {
        uid = params[:uid]
        send_file "app/assets/excels/#{uid}.xls"
      }
    end
  end

end
