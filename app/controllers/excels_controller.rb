class ExcelsController < ApplicationController

  def index
  end

  def import
    if params[:file].present?
      FileUtils.rm_rf(Dir.glob("app/assets/excels/*"))
      @book = Spreadsheet.open(params[:file].path)
      @sheet1 = @book.worksheet 0
      number_row = @sheet1.row_count
      to1 = Settings.from1 + Settings.number1 - 1
      to2 = Settings.from2 + Settings.number2 - 1
      ((Settings.from1)..to1).each do |index|
        t_book = Spreadsheet.open ("app/assets/templates/template.xls")
        t_sheet = t_book.worksheet 0
        (0..@sheet1.column_count-1).each do |i|
          t_sheet.row(Settings.from1 - 1).insert i, @sheet1.row(index)[i]
        end
        uid = @sheet1.row(index)[Settings.uid_column]
        if !User.find_uid(uid).blank? 
          t_book.write "app/assets/excels/#{uid}.xls"
        end
      end
      ((Settings.from2)..to2).each do |index|
        t_book = Spreadsheet.open ("app/assets/templates/template.xls")
        t_sheet = t_book.worksheet 0
        (0..@sheet1.column_count-1).each do |i|
          t_sheet.row(Settings.from1 - 1).insert i, @sheet1.row(index)[i]
        end
        uid = @sheet1.row(index)[Settings.uid_column]
        if !User.find_uid(uid).blank? 
          t_book.write "app/assets/excels/#{uid}.xls"
        end
      end
      flash[:success] = "imported!"
      SentUser.all.delete_all
      User.all.each do |user|
        sent_user = SentUser.create(uid: user.uid, sent: false, note: params[:file].original_filename)
      end
      redirect_to excels_list_user_path
    else
      flash[:error] = "Chosen file to import!"
      redirect_to root_path
    end
  end

  def list_user
    @users = User.all
    @names = []
    @uids = []
    @users_not_in_file =[]
    @users.each do |user|
      if !(user.email.include? "deactivated")
        if File.exists?("app/assets/excels/#{user.uid}.xls")
          book = Spreadsheet.open("app/assets/excels/#{user.uid}.xls")
          sheet = book.worksheet 0
          @names.push(sheet.row(Settings.from1-1)[Settings.display_name_column])
          @uids.push(sheet.row(Settings.from1-1)[Settings.uid_column])
        else
          @users_not_in_file.push(user.email)
        end
      end
    end
  end

  def sent_email
    @uid = params[:uid]
    user = User.find_by(uid: @uid)
    Notifier.delay.sent_mail(user)
    SentUser.find_by(uid: @uid).update_attributes(sent: true)
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
  end
end


