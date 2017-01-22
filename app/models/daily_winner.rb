class DailyWinner < ApplicationRecord

  validates_presence_of :date, :users
  validates_uniqueness_of :date
end
