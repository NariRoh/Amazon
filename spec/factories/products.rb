FactoryGirl.define do
  factory :product do
    sequence(:title)       { |n| Faker::Pokemon.name + "_#{n}" }
    description            { Faker::Pokemon.location }
    price                  { Faker::Number.decimal(2) }
  end
end
