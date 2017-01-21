class AddLiveIdToChatReports < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_reports, :live_id, :integer
  end
end
