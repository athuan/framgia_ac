class ExcelsController < ApplicationController

  def index
  end

  def import
    if params[:file].present?
      import_xls params[:file]
      flash[:success] = "imported!"
      salary_report = SalaryReport.create(month: params[:date][:month], year: params[:date][:year])
      User.all.each do |user|
        if File.exists? Settings.excel_files + '/' + user.uid + '.xls'
          sent_user = SentUser.create(uid: user.uid, sent: false, salary_report_id: salary_report.id)
        end
      end
      redirect_to excels_list_user_path(salary_report_id: salary_report.id)
    else
      flash[:error] = "Chosen file to import!"
      redirect_to root_path
    end
  end

  def list_user
    #@users = User.actives
    @salary_report_id = params[:salary_report_id]
    @sent_users = SalaryReport.find(@salary_report_id).sent_users
    @names = load_metadata
  end

  def sent_email
    @uid = params[:uid]
    salary_report_id = params[:salary_report_id]
    user = User.find_by(uid: @uid)
    Notifier.delay.sent_mail(user)
    SalaryReport.find(salary_report_id).sent_users.find_by(uid: @uid).update_attributes(sent: true)
    respond_to do |format|
      format.html { redirect_to excels_list_user_path }
      format.js
    end
  end

  def sent_all
    User.all.each do |user|
      Notifier.delay.sent_mail(user)
      SentUser.find_by(uid: user.uid).update_attributes(sent: true)
    end
    redirect_to :back
  end

  def download
    uid = params[:uid]
    send_file "app/assets/excels/#{uid}.xls"
    #redirect_to excels_list_user_path
  end

  def finish
    FileUtils.rm_rf(Dir.glob(Settings.excel_files + "/*"))
    redirect_to root_path
  end
end


