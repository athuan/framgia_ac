module ApplicationHelper

  def export book, sheet, from1, to1, from2, to2, uid, uid_column
    remove_row sheet, from1, to1, from2, to2, uid, uid_column
    book.write "app/assets/excels/#{uid}.xls"
  end

  def remove_row sheet, from1, to1, from2, to2, uid, uid_column
    number_column = sheet.column_count
    number_row = sheet.row_count
    
    sheet.row(number_row).insert 0, nil
    (from1..to1).each do |i|
      if sheet.row(i)[uid_column] != uid
        sheet.row(i).hidden = true
      else
        ((to1 + 1)..(from2 - 1)).each do |j|
          sheet.row(j).hidden = true
        end
      end
    end
    (from2..to2).each do |i|
      if sheet.row(i)[uid_column] != uid
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
end
