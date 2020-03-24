FactoryBot.define do
  factory :recurring_event, class: 'RecurringEvent', parent: :event do
    start_date do
      Faker::Time.between(from: Date.current, to: Date.current + 7)
    end
    end_date do
      Faker::Time.between(
        from: start_date,
        to: start_date + 77.days
      )
    end
    user
  end

  trait :daily do
    recurrence do
      Montrose.every(:day, starts: start_date, until: end_date)
    end
  end

  trait :invalid_recurring_event do
    start_date { nil }
    end_date { nil }
  end

  trait :weekly do
    recurrence do
      Montrose.every(:week, starts: start_date, until: end_date)
    end
  end

  trait :monthly do
    recurrence do
      Montrose.every(:month, starts: start_date, until: end_date)
    end
  end

  trait :yearly do
    recurrence do
      Montrose.every(:year, starts: start_date, until: end_date)
    end
  end
end
