FactoryBot.define do
  sequence :title do |n|
    "Task ##{n}"
  end

  factory :task do
    title

    trait :invalid do
      title { nil }
    end

    trait :done do
      is_done { true }
    end

    trait :new do
      title { 'New title' }
      description { 'New description' }
    end
  end
end
