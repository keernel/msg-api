module Api::V1
  class ChatsController < ApiController
    # POST api/v1/close_chat/:chat_id
    def close_chat
      # Check if the chat exists
      chat = Chat.find(params[:chat][:id])

      # 1 -Check if the chat exists in redis and if it has messages
      messages = find_redis_chat(chat.id)

      if messages.any?
        # 2- Creates the chat/live on db
        chat = Chat.create
        # 3- Save the redis associated chat/live messages to db
        create_chat_messages(chat, messages)
      end


      render status: 200, json: {
        chat: chat
      }.to_json
    end

    def create_chat_messages(chat, messages)
      messages.each do |m|
        if m.grep(/msg/).any?
          new_message = JSON.parse m[1]
          message = chat.messages.new(new_message)
          message.user = User.find_or_create_by id: new_message["user_id"]
          message.save
        end
      end
    end

    def find_redis_chat(chat_id)
      messages = $redis_msg.hgetall("chat-#{chat_id}")
      return messages.any? ? messages : nil
    end

    private
    def chat_params
      params.require(:chat).permit(:id)
    end
  end
end
