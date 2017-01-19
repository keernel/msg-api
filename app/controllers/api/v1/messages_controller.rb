module Api::V1
  class MessagesController < ApiController

    # POST api/v1/add_to_redis
    def add_to_redis
      # Parse and validated message
      message = Message.new(message_params)
      message.sent_at = Time.now
      unless message.valid?
        render status: 422, json: {
          error: message.errors.messages
        }.to_json
        return
      end
      json_message = message.to_json

      # Create first message for this chat/live
      if $redis_msg.hgetall("chat-#{message.chat_id}").nil?
        $redis_msg.hset("chat-#{message.chat_id}", "message_id", 1)
        $redis_msg.hset("chat-#{message.chat_id}", "msg-1}", json_message)
      # Create new message on redis an increment message_id, key also used for totalization
      else
        message_id = $redis_msg.hincrby("chat-#{message.chat_id}", "message_id", 1)
        $redis_msg.hset("chat-#{message.chat_id}", "msg-#{message_id}", json_message)
      end
      render status: 200, json: {
        message: message
      }.to_json

      ######
      # $redis_msg.hgetall("chat-#{message.chat_id}")
      ######

      # Get Live/Chat current redis data

      # Send notification to Pusher
        # Or do nothing, because it could be sent within the client

    end

    private

    def message_params
      params.require(:message).permit(:body, :user_id, :chat_id)
    end

  end
end
