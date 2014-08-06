module ApplicationHelper

  def export book, sheet, from1, to1, from2, to2, display_name, display_name_column
    remove_row sheet, from1, to1, from2, to2, display_name, display_name_column
    dir = "app/assets/excels"
    Dir.mkdir(dir) unless File.exists?(dir)
    book.write "app/assets/excels/#{display_name}.xls"
  end

  def remove_row sheet, from1, to1, from2, to2, display_name, display_name_column
    number_column = sheet.column_count
    number_row = sheet.row_count
    
    sheet.row(number_row).insert 0, nil
    (from1..to1).each do |i|
      if sheet.row(i)[display_name_column] != display_name
        sheet.row(i).hidden = true
      else
        ((to1 + 1)..(from2 - 1)).each do |j|
          sheet.row(j).hidden = true
        end
      end
    end
    (from2..to2).each do |i|
      if sheet.row(i)[display_name_column] != display_name
        sheet.row(i).hidden = true
      else
        sheet.row(from1 - 1).hidden = true
        ((to1 + 1)..(from2 - 2)).each do |j|
          sheet.row(j).hidden = true
        end
      end
    end
    ((to2 + 1)..Settings.end).each do |i|
      sheet.row(i).hidden = true
    end
  end

  def get_value_cell sheet, row, column
    sheet.row(row)[column]
  end

  def get_column_values sheet, column
    values = []
    (Settings.from1..(Settings.from1 + Settings.number1 - 1)).each do |i|
      values.push(sheet.row(i)[column])
    end
    (Settings.from2..(Settings.from2 + Settings.number2 - 1)).each do |i|
      values.push(sheet.row(i)[column])
    end
    values
  end

  def get_users sheet
    users =[]
    (Settings.from1..(Settings.from1 + Settings.number1 - 1)).each do |i|
      users.push(sheet.row(i))
    end
    (Settings.from2..(Settings.from2 + Settings.number2 - 1)).each do |i|
      users.push(sheet.row(i))
    end
    users
  end

  def get_order sheet, display_name
    (Settings.from1..(Settings.from1 + Settings.number1 - 1)).each do |i|
      if sheet.row(i)[Settings.display_name_column] == display_name
        return i
      end
    end
    (Settings.from2..(Settings.from2 + Settings.number2 - 1)).each do |i|
      if sheet.row(i)[Settings.display_name_column] == display_name
        return i
      end
    end
  end

  def arr_users
    users = []
    i = 0
    User.all.each do |user|
      users[i] = user.display_name
      users[i+1] = user.uid
      i += 2
    end
    users
  end

  def load_metadata
    data = []
    if File.exists?(Settings.excel_files + '/source.xls')
      book = Spreadsheet.open(Settings.excel_files + '/source.xls')
      sheet = book.worksheet 1
      data = load_data sheet, Settings.from1, Settings.number1
      data = data + load_data(sheet, Settings.from2, Settings.number2)
    end
    data
  end

  def import_xls file
    dir = "app/assets/excels"
    Dir.mkdir(dir) unless File.exists?(dir)
    FileUtils.rm_rf(Dir.glob(Settings.excel_files + "/*"))
    File.open(Settings.excel_files + '/source.xls', 'wb') do |f|
      f.write(file.read)
    end
    book = Spreadsheet.open(file.path)
    sheet1 = book.worksheet 1
    number_row = sheet1.row_count
    separate_file sheet1, Settings.from1, Settings.number1
    separate_file sheet1, Settings.from2, Settings.number2
  end

  def write workbook, url
    workbook.write url
    # File.open(url, "wb+") do |fh|
    #   write_workbook workbook, fh
    # end
  end

  private
  def write_workbook workbook, io
    reader = workbook.io
    unless io == reader
      reader.rewind
      data = reader.read
      io.rewind
      io.write data
    end
  end

  def separate_file sheet, from, number
    to = from + number - 1
    (from..to).each do |index|
      t_book = Spreadsheet.open ("app/assets/templates/template.xls")
      t_sheet = t_book.worksheet 0
      (0..sheet.column_count - 1).each do |i|
        t_sheet.row(from - 1).insert i, get_cell_value(sheet, index, i)
      end
      uid = sheet.row(index)[Settings.uid_column]
      write t_book, "app/assets/excels/#{uid}.xls"
    end
  end

  def load_data sheet, from, number
    data = Array.new
    to = from + number - 1
    (from..to).each do |index|
      uid = get_cell_value(sheet, index, Settings.uid_column)
      logger.info uid.to_s
      name = get_cell_value(sheet, index, Settings.display_name_column)
      unless (uid.nil? || uid.empty?)
        data << [uid, name]
      end
    end
    data
  end

  def get_cell_value sheet, row, col
    if sheet.row(row)[col].is_a? Spreadsheet::Formula
      return sheet.row(row)[col].value
    else
      sheet.row(row)[col]
    end
  end

end
