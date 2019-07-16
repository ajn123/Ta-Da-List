FactoryBot.define do
  
  factory :list_one, class: List do
    title { Faker::Lorem.sentence}
  end
end
