module Api::V1
  class ChatsController < ApiController

    # GET api/v1/chat_report/
    def chat_report
      chat_report = ChatReport.find_by live_id: chat_params[:id]

      if chat_report.present?
        render status: 200, json: {
          chat_report: chat_report
        }
      else
        render status: 404
      end
    end

    # POST api/v1/close_chat/
    def close_chat
      messages = ApiServices.find_redis_chat(chat_params[:id])

      if messages.nil?
        render status: 404
      else
        chat = Chat.create(live_id: chat_params[:id])
        ApiServices.create_chat_messages(chat, messages)
        chat_report = ApiServices.create_chat_report(chat)

        render status: 200, json: {
          chat: chat,
          chat_report: chat_report
        }
      end
    end

    private
    def chat_params
      params.require(:chat).permit(:id)
    end
  end
end
