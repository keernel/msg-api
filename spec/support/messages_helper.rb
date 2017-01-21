module MessagesHelper
  def mock_redis_messages(messages, redis_msg)
    messages.each do |m|
      message_id = redis_msg.hincrby("live-1", "message_id", 1)
      redis_msg.hset("live-1", "msg-#{message_id}", m.to_json)
    end
  end
end
