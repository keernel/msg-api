class ApiServices
  def self.create_chat_messages(chat, messages)
    messages.each do |m|
      if m.grep(/msg/).any?
        new_message = JSON.parse m[1]
        message = chat.messages.new(new_message)
        message.user = User.find_or_create_by id: new_message["user_id"]
        message.save
      end
    end
  end
  def self.find_redis_chat(chat_id)
    messages = $redis_msg.hgetall("chat-#{chat_id}")
    return messages.any? ? messages : nil
  end

  def self.create_chat_report(chat)
    chat_report = ChatReport.create(chat: chat,
     qty_messages: chat.messages.length,
     qty_of_users: chat.users.uniq.length
    )
  end
end
