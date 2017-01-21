module Api::V1
  class ChatsController < ApiController
    # POST api/v1/close_chat
    def close_chat
      # Check if the chat exists
      chat = Chat.find(params[:chat][:id])
    end
    private
    def chat_params
      params.require(:chat).permit(:id)
    end
  end
end
