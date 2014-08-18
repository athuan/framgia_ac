class CreateSentUsers < ActiveRecord::Migration
  def change
    create_table :sent_users do |t|
      t.integer :salary_report_id
      t.string :uid
      t.boolean :sent

      t.timestamps
    end
  end
end
