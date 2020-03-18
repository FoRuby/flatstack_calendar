FactoryBot.define do
  factory :recurring_event, class: 'RecurringEvent', parent: :event do
    schedule { 'day' }
    start_date do
      Faker::Time.between(from: Date.current, to: Date.current + 7)
    end
    end_date do
      Faker::Time.between(
        from: start_date,
        to: start_date + 50.days
      )
    end
  end

  trait :daily do
    schedule { 'day' }
  end

  trait :weekly do
    schedule { 'week' }
  end

  trait :monthly do
    schedule { 'month' }
  end

  trait :yearly do
    schedule { 'year' }
  end
end
