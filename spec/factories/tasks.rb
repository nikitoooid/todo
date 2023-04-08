FactoryBot.define do
  sequence :title do |n|
    "Task ##{n}"
  end

  sequence :due_date do |n|
    Time.zone.today + n.days
  end

  factory :task do
    title
    due_date

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
