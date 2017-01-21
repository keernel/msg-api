class AddLiveIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :live_id, :integer
  end
end
