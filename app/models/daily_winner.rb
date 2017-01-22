class DailyWinner < ApplicationRecord

  validates_presence_of :date, :users
end
