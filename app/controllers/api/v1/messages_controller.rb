module Api::V1
  class MessagesController < ApiController

    # GET /v1/messages
    def add_to_redis
      # time = Benchmark.measure do
      # Parse and validated message
      message = Message.new(message_params)
      message.sent_at = Time.now

      # binding.pry

      unless message.valid?
        render status: 422, json: {
            error: message.errors.messages
          }.to_json
          return
      end

      json_message = message.to_json

      # Create first message for this chat/live, if its first message
      if $redis_msg.hgetall("chat-#{message.chat_id}").nil?
          $redis_msg.hset("chat-#{message.chat_id}", "message_id", 1)
          $redis_msg.hset("chat-#{message.chat_id}", "msg-1}", json_message)
      end

      # Create new message on redis an increment message_id, key also used to totalization
      message_id = $redis_msg.hincrby("chat-#{message.chat_id}", "message_id", 1)
      $redis_msg.hset("chat-#{message.chat_id}", "msg-#{message_id}", json_message)

      # end
      # render json: time
      render status: 200, json: {
          message: message
        }.to_json

      ######
      # $redis_msg.hgetall("chat-#{message.chat_id}")
      ######

      # Get Live / Chat current redis data
      # redis_messages = JSON.load($redis_msg.hgetall("chat-#{message.chat_id}"))
      # redis_messages.merge message.to_json


      # Send notification to Pusher
        # Or do nothing, because it could be sent with the client

    end

    private

    def message_params
      params.require(:message).permit(:body, :user_id, :chat_id)
    end

  end
end
