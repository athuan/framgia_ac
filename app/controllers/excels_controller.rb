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
        uid = sheet.row(index)[Settings.uid_column]
        if !uid.nil?
          export(book, sheet, Settings.from1, to1, Settings.from2, to2,
            uid, Settings.uid_column) 
        end
      end
      ((Settings.from2)..to2).each do |index|
        book = Spreadsheet.open(params[:file].path)
        sheet = book.worksheet 0
        uid = sheet.row(index)[Settings.uid_column]
        if !uid.nil?
          export(book, sheet, Settings.from1, to1, Settings.from2, to2,
            uid, Settings.uid_column)
        end
      end
      flash[:success] = "imported!"
    else
      flash[:error] = "Chosen file to import!"
    end
    User.all.each do |user|
      Notifier.delay.sent_mail(user)
    end
    redirect_to :back
  end
end


