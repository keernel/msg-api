class CreateDailyWinners < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_winners do |t|
      t.date :date
      t.text :users

      t.timestamps
    end
  end
end
