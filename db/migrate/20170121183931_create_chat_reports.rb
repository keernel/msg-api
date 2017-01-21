class CreateChatReports < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_reports do |t|
      t.integer :qty_messages
      t.integer :qty_of_users
      t.integer :chat_id

      t.timestamps
    end
  end
end
