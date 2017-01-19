class User < ApplicationRecord
  has_many :messages
  has_many :chats, through: :messages

  validates_presence_of :name
end
