module MessagesHelper
  def mock_redis_messages(messages, redis_msg)
    messages.each do |m|
      message_id = redis_msg.hincrby("chat-1", "message_id", 1)
      redis_msg.hset("chat-1", "msg-#{message_id}", m.to_json)
    end
  end
end
