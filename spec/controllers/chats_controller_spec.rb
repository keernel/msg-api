require 'rails_helper'
include MessagesHelper

describe Api::V1::ChatsController, type: :controller do

  context 'close_chat request' do
    context 'with a wrong chat_id' do
      it 'responds with a 404 status' do
        post :close_chat, params: { chat: { id: 1 } }
        expect(response.status).to eq 404
      end
    end

    context 'with an existing chat_id' do
      let(:messages) { build_list(:message, 10, :new_user, chat_id: 1) }
      $redis_msg.hset("chat-1", "message_id", 0)

      before do
        MessagesHelper.mock_redis_messages(messages, $redis_msg)
      end

      it 'responds with a 200 status' do
        post :close_chat, params: { chat: { id: 1 } }
        expect(response.status).to eq 200
      end
    end
  end
  context 'chat_report request' do

    before do
      @chat = create :chat
      @chat_report = ApiServices.create_chat_report(@chat)
    end

    context 'with a wrong chat_id' do
      it 'responds with a 404 status' do
        post :chat_report, params: { chat: { id: 123 } }
        expect(response.status).to eq 404
      end
    end
    context 'with an existing chat_id' do
      it 'responds with a 200 status' do
        post :chat_report, params: { chat: { id: @chat.id } }
        expect(response.status).to eq 200
      end
    end
  end
end

