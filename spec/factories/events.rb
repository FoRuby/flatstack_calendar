FactoryBot.define do
  factory :event do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    date { Faker::Time.between(from: Date.current, to: Date.current + 7.days) }
    duration { rand(1..3) }

    visibility { 'private' }
    color { Faker::Color.hex_color }
  end

  trait :invalid_event do
    title { nil }
    date { nil }
    recurring_start_date { nil }
    recurring_end_date { nil }
    visibility { 'foobar' }
    color { 'foobar' }
  end
end
