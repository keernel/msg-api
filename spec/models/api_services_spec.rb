require 'rails_helper'
include MessagesHelper

RSpec.describe ApiServices, type: :model do
  let(:messages) { build_list(:message, 10, :new_user, live_id: 1) }
  let(:chat) { create(:chat, live_id: 1) }
  $redis_msg.hset('live-1', 'message_id', 0)

  before do
    MessagesHelper.mock_redis_messages(messages, $redis_msg)
    @redis_chat = ApiServices.find_redis_chat(1)
    ApiServices.create_chat_messages(chat, @redis_chat)
  end

  it 'find redis chat and returns a Hash with messages' do
    expect(@redis_chat.class).to eq Hash
    expect(@redis_chat.length).to eq messages.length + 1
  end

  it 'create messages on DB based on Hash of redis messages' do
    message = JSON.parse @redis_chat['msg-1']
    expect(@redis_chat.length - 1).to eq Message.count
    expect(message['body']).to eq Message.first.body
  end

  it 'create chat report with a valid chat' do
    chat_report = ApiServices.create_chat_report(chat)
    expect(chat_report.qty_messages).to eq chat.messages.length
    expect(chat_report.qty_of_users).to eq chat.users.uniq.length
  end
end
