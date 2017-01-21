module Api::V1
  class ChatsController < ApiController
    # POST api/v1/close_chat
    def close_chat
      # Check if the chat exists
      chat = Chat.find(params[:chat][:id])

      render status: 200, json: {
        chat: chat
      }.to_json
    end
    private
    def chat_params
      params.require(:chat).permit(:id)
    end
  end
end
