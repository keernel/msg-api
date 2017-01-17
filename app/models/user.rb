class User < ApplicationRecord
  has_many :messages
  has_many :chats, through: :messages
end
