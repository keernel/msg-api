module Api::V1
  class MessagesController < ApiController
    # POST api/v1/add_to_redis
    def add_to_redis
      # Parse and validated message
      # BEGIN ============================ Refactor to class method ==============================
      message = Message.new(message_params)
      message.sent_at = Time.now
      unless message.valid?
        render status: 422, json: {
          error: message.errors.messages
        }.to_json
        return
      end
      json_message = message.to_json(only: [:user_id, :live_id, :body, :sent_at])

      # Create first message for this chat/live
      if $redis_msg.hgetall("live-#{message.live_id}").nil?
        $redis_msg.hset("live-#{message.live_id}", "message_id", 1)
        $redis_msg.hset("live-#{message.live_id}", "msg-1}", json_message)
      # Create new message on redis an increment message_id, key also used for totalization
      else
        message_id = $redis_msg.hincrby("live-#{message.live_id}", "message_id", 1)
        $redis_msg.hset("live-#{message.live_id}", "msg-#{message_id}", json_message)
      end

      # Send notification to Pusher
      Pusher.trigger("live-#{message.live_id}", "new_message", json_message)
      # ============================ Refactor to class method ============================== END

      render status: 200, json: {
        message: message
      }.to_json
      ####### Get Live/Chat current redis data
      # $redis_msg.hgetall("live-#{message.live_id}")
      ######
    end

    private

    def message_params
      params.require(:message).permit(:body, :user_id, :live_id)
    end

  end
end
