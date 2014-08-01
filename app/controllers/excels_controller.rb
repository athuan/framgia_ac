class ExcelsController < ApplicationController

  def index
  end

  def import
    if params[:file].present?
      @book = Spreadsheet.open(params[:file].path)
      @sheet1 = @book.worksheet 0
      number_row = @sheet1.row_count
      to1 = Settings.from1 + Settings.number1 - 1
      to2 = Settings.from2 + Settings.number2 - 1
      ((Settings.from1)..to1).each do |index|
        book = Spreadsheet.open(params[:file].path)
        sheet = book.worksheet 0
        display_name = sheet.row(index)[Settings.display_name_column]
        if !display_name.nil?
          export(book, sheet, Settings.from1, to1, Settings.from2, to2,
            display_name, Settings.display_name_column) 
        end
      end
      ((Settings.from2)..to2).each do |index|
        book = Spreadsheet.open(params[:file].path)
        sheet = book.worksheet 0
        display_name = sheet.row(index)[Settings.display_name_column]
        if !display_name.nil?
          export(book, sheet, Settings.from1, to1, Settings.from2, to2,
            display_name, Settings.display_name_column)
        end
      end
      flash[:success] = "imported!"
    else
      flash[:error] = "Chosen file to import!"
    end
    SentUser.all.delete_all
    User.all.each do |user|
      sent_user = SentUser.create(uid: user.uid, sent: false, note: params[:file].original_filename)
    end
    redirect_to excels_list_user_path
  end

  def list_user
    @users = User.all
    #@uids =[]
    @names = []
    @users.each do |user|
      if !user.email.include? "deactivated"
        book = Spreadsheet.open("app/assets/excels/#{user.display_name}.xls")
        sheet = book.worksheet 0
        #@uids.push(sheet.row(get_order(sheet, user.uid))[Settings.uid_column])
        @names.push(sheet.row(get_order(sheet, user.display_name))[Settings.display_name_column])
      end
    end
  end

  def sent_email
    uid = params[:uid]
    user = User.find_by(uid: uid)
    Notifier.delay.sent_mail(user)
    SentUser.find_by(uid: uid).update_attributes(sent: true)
    redirect_to :back
  end

  def sent_all
    User.all.each do |user|
      Notifier.delay.sent_mail(user)
      SentUser.find_by(uid: user.uid).update_attributes(sent: true)
    end
    redirect_to :back
  end

  def download
    display_name = params[:display_name]
    send_file "app/assets/excels/#{display_name}.xls"
  end
end


