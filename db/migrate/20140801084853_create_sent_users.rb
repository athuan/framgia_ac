class CreateSentUsers < ActiveRecord::Migration
  def change
    create_table :sent_users do |t|
      t.string :uid
      t.boolean :sent
      t.string :note

      t.timestamps
    end
  end
end
