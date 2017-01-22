class MostActiveUsersJob < ApplicationJob
  queue_as :default

  def perform(date = nil)
    date = Date.parse date
    date ||= Date.today
    puts "Working on most active users on #{date}..."
    # 1- Get all date messages and users that sent message on this date
    users = User.joins(:messages).where('messages.sent_at BETWEEN ? AND ?', date.beginning_of_day, date.end_of_day)
    # 2- Order them by number of messages
    users = users.group("users.id").order("count(messages.id) DESC")
    # 3- Get the top 3
    winners = users.count.first 3
    # 4- Save them to DB
    puts "The winners are: [:id, :qty_of_messages] #{winners}"
    DailyWinner.create date: date, users: winners
  end
end
