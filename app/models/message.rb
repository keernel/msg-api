class Message < ApplicationRecord
  belongs_to :chat, optional: true # Optional to deal with temp save on redis
  belongs_to :user, optional: true

  validates_presence_of :body, :user_id, :live_id, :sent_at
end
