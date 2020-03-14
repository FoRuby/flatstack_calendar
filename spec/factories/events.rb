FactoryBot.define do
  factory :event do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    start_date { Date.today + rand(7) }
    end_date {}
    event_type { 'private' }
    color { Faker::Color.hex_color }
  end

  after :build do |event|
    event.end_date = event.start_date + rand(7)
  end
end
