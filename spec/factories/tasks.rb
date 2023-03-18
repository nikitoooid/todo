FactoryBot.define do
  sequence :title do |n|
    "Task ##{n}"
  end

  factory :task do
    title

    trait :invalid do
      title { nil }
    end
  end
end
