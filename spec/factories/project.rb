FactoryGirl.define do
  factory :project do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence(3) }
  end
end
