FactoryBot.define do
  factory :event do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    start_date { Date.today + rand(7) }
    end_date {}
    event_type { 'private' }
    color { Faker::Color.hex_color }

    transient do
      callback? { true }
    end
  end

  after :build do |event, options|
    event.end_date = event.start_date + rand(7) if options.callback?
  end

  trait :invalid_event do
    title { nil }
    start_date { nil }
    event_type { 'foobar' }
    color { 'foobar' }
  end
end
