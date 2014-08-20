class SalaryReportsController < ApplicationController

  def index
  end

  def new
    @salary_report = SalaryReport.new
  end

  def create
    @salary_report = SalaryReport.new salary_report_params
    @salary_report.finish = false
    if params[:salary_report][:file].present?
      if @salary_report.save
        import_xls params[:salary_report][:file]
        User.all.each do |user|
          if File.exists? Settings.excel_files + "/" + user.uid + ".xls"
            SentUser.create(uid: user.uid, sent: false, salary_report_id: @salary_report.id)
          end
        end
        flash[:success] = "imported!"
        redirect_to @salary_report 
      else
        flash[:error] = "Import error!"
        render "new"
      end
    else
      flash[:fail] = "Chosen file to import!"
      redirect_to root_path
    end
  end

  def show
    @salary_report = SalaryReport.find params[:id]
    @sent_users = @salary_report.sent_users
    @names = load_metadata
  end

  def update
    @salary_report = SalaryReport.find params[:id]
    @salary_report.update_attributes(finish: true)
    FileUtils.rm_rf(Dir.glob(Settings.excel_files + "/*"))
    redirect_to root_path
  end

  private
    def salary_report_params
      params.require(:salary_report).permit(:month, :year, :finish)
    end
end


