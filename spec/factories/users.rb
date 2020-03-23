FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    confirmed_at { Time.now }
  end

  trait :invalid_user do
    name { '' }
    email { '' }
    password { '' }
    password_confirmation { '' }
  end
end
