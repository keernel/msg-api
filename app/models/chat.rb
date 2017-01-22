class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  has_one :chat_report

  validates_uniqueness_of :live_id
end
