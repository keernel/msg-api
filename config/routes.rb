Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :add_to_redis, to: "messages#add_to_redis"
      post :close_chat, to: "chats#close_chat"
      post :chat_report, to: "chats#chat_report"
      post :winners_on_date, to: "daily_winners#winners_on_date"
    end
  end
end
