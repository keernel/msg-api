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
  end
end
