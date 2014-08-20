class CreateSalaryReports < ActiveRecord::Migration
  def change
    create_table :salary_reports do |t|
      t.string :month
      t.string :year
      t.boolean :finish

      t.timestamps
    end
  end
end
