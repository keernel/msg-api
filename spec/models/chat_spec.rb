require 'rails_helper'

RSpec.describe Chat, type: :model do
  let(:chat) { build(:chat) }

  it 'has a valid factory' do
    expect(chat).to be_valid
  end
end
