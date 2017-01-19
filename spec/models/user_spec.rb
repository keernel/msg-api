require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end
  it 'has ActiveModel Validations' do
    expect(user).to validate_presence_of(:name)
  end
end
