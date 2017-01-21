require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { build(:message, :new_live, :new_user) }
  # Use factories traits to deal with chats and users that isn't on our db yet
  it 'has a valid factory' do
    expect(message).to be_valid
  end

  it 'has ActiveModel Validations' do
    expect(message).to validate_presence_of(:body)
    expect(message).to validate_presence_of(:sent_at)
  end
end
