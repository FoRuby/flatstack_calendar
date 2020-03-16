FactoryBot.define do
  factory :recurring_event, class: 'RecurringEvent', parent: :event do
    schedule { 'recurring_event_schedule' }
    recurring_start_date do
      Faker::Time.between(from: date, to: date - 7.days)
    end
    recurring_end_date do
      Faker::Time.between(
        from: recurring_start_date,
        to: recurring_start_date + 50.days
      )
    end
  end

  trait :daily do
    schedule do
      IceCube::Schedule.new(date) do |schedule|
        schedule.add_recurrence_rule(IceCube::Rule.daily)
      end
    end
  end

  trait :weekly do
    schedule do
      IceCube::Schedule.new(date) do |schedule|
        schedule.add_recurrence_rule IceCube::Rule.weekly
      end
    end
  end

  trait :monthly do
    schedule do
      IceCube::Schedule.new(date) do |schedule|
        schedule.add_recurrence_rule IceCube::Rule.monthly
      end
    end
  end

  trait :yearly do
    schedule do
      IceCube::Schedule.new(date) do |schedule|
        schedule.add_recurrence_rule IceCube::Rule.yearly
      end
    end
  end
end
