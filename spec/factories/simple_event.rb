FactoryBot.define do
  factory :simple_event, class: 'SimpleEvent', parent: :event do
    date { Faker::Time.between(from: Date.current, to: Date.current + 7.days) }
    duration { rand(1..3) }
    user
  end

  trait :invalid_simple_event do
    date { nil }
    duration { nil }
  end
end
