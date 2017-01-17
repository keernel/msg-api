class Message < ApplicationRecord
  belongs_to :chat, optional: true # Because chat isn't created yet on temp
  belongs_to :user

  validates_presence_of :body, :user_id, :chat_id, :sent_at
end
