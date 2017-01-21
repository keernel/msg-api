class AddLiveIdToChats < ActiveRecord::Migration[5.0]
  def change
    add_column :chats, :live_id, :integer
  end
end
