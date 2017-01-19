require 'rails_helper'

describe Api::V1::MessagesController, type: :controller do
  before(:each) do
    @message = build(:message, :new_chat, :new_user)
    @new_message = @message.as_json(only: [:chat_id, :user_id, :body])
  end

  # TBD STUB REDIS OR USE FAKEREDIS

  context 'with correct data' do
    before do
      post :add_to_redis, params: { message: @new_message }
    end
    it 'responds with a 200 status' do
      expect(response.status).to eq 200
    end
    it 'responds with the added message' do
      parsed_data = JSON.parse response.body
      parsed_message = parsed_data['message']
      expect(parsed_message['body']).to eq(@message.body)
    end
  end

  context 'with wrong data' do
  end
end
