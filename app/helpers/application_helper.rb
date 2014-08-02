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

end
