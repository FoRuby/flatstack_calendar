FactoryBot.define do
  factory :event do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    start_date do
      Faker::Time.between(from: Time.now, to: Time.now + 7.days)
    end
    end_date do
      Faker::Time.between(from: start_date, to: start_date + 7.days)
    end
    schedule { nil }
    event_type { 'private' }
    color { Faker::Color.hex_color }
  end

  trait :invalid_event do
    title { nil }
    start_date { nil }
    end_date { nil }
    event_type { 'foobar' }
    color { 'foobar' }
  end

  trait :daily do
    schedule do
      IceCube::Schedule.new(start_date) do |s|
        s.add_recurrence_rule(IceCube::Rule.daily)
      end.to_yaml
    end
  end

  trait :weekly do
    schedule do
      IceCube::Schedule.new(start_date) do |schedule|
        schedule.add_recurrence_rule IceCube::Rule.weekly
      end.to_yaml
    end
  end

  trait :monthly do
    schedule do
      IceCube::Schedule.new(start_date) do |schedule|
        schedule.add_recurrence_rule IceCube::Rule.monthly
      end.to_yaml
    end
  end

  trait :yearly do
    schedule do
      IceCube::Schedule.new(start_date) do |schedule|
        schedule.add_recurrence_rule IceCube::Rule.yearly
      end.to_yaml
    end
  end
end
