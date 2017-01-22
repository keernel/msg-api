require 'faker'

FactoryGirl.define do
  factory :message do
    body { Faker::StarWars.quote }
    sent_at { Faker::Time.between(5.minutes.ago, 1.minute.ago, :all) }

    trait(:new_live) do
      live_id { Faker::Number.between(1, 10) }
    end

    trait(:new_user) do
      user_id { Faker::Number.between(1, 10) }
    end

    trait(:fake_user) do
      association :user, factory: :user
    end

    trait(:fake_chat) do
      association :chat, factory: (:chat)
      after(:create) do |message|
        message.chat.update_attribute(:live_id, message.live_id) unless message.chat.live_id.present?
      end
    end
  end
end
