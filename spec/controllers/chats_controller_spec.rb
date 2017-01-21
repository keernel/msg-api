require 'rails_helper'
include MessagesHelper

describe Api::V1::ChatsController, type: :controller do

  context 'close_chat request' do
    let(:messages) { build_list(:message, 10, :new_user, chat_id: 1) }
    $redis_msg.hset("chat-1", "message_id", 0)

    before do
      MessagesHelper.mock_redis_messages(messages, $redis_msg)
    end

    context 'with a wrong chat_id' do
      it 'responds with a 404 status' do
        post :close_chat, params: { chat: { id: 1 } }
        expect(response.status).to eq 404
      end
    end
  end
end

