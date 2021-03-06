require 'rails_helper'

describe Api::V1::MessagesController, type: :controller do
  context 'add_to_redis request' do
    let(:message) { build(:message, :new_live, :new_user) }
    let(:new_message) { message.as_json(only: [:live_id, :user_id, :body]) }

    context 'with correct data' do
      before do
        post :add_to_redis, params: { message: new_message }
      end
      it 'responds with a 200 status' do
        expect(response.status).to eq 200
      end
      it 'responds with the added message' do
        parsed_data = JSON.parse response.body
        parsed_message = parsed_data['message']
        expect(parsed_message['body']).to eq(message.body)
      end
    end
    context 'with wrong data' do
      before do
        post :add_to_redis, params: { message: { wrong: 'data' } }
      end
      it 'responds with a 422 status' do
        expect(response.status).to eq 422
      end
    end
    context 'with missing params' do
      # TBD REFACTOR
      it 'respond with error for missing live_id' do
        post :add_to_redis, params: { message: new_message.except('live_id') }
        expect(response.body).to eq "{\"error\":{\"live_id\":[\"can't be blank\"]}}"
      end

      it 'respond with error for missing user_id' do
        post :add_to_redis, params: { message: new_message.except('user_id') }
        expect(response.body).to eq "{\"error\":{\"user_id\":[\"can't be blank\"]}}"
      end

      it 'respond with error for missing body' do
        post :add_to_redis, params: { message: new_message.except('body') }
        expect(response.body).to eq "{\"error\":{\"body\":[\"can't be blank\"]}}"
      end
    end
  end
end

