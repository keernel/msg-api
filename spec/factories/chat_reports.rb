FactoryGirl.define do
  factory :chat_report do
    qty_messages { Faker::Number.between(1, 10) }
    qty_of_users { Faker::Number.between(1, 10) }
    live_id { Faker::Number.between(1, 10) }

    trait(:fake_chat) do
      association :chat, factory: :chat
    end
  end

end
