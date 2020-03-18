FactoryBot.define do
  factory :event, class: 'Event' do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    visibility { 'private' }
    color { Faker::Color.hex_color }
  end

  trait :invalid_event do
    title { nil }
    description { nil }
    visibility { 'foobar' }
    color { 'foobar' }
  end
end
