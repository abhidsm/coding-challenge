FactoryBot.define do
  
  factory :project do
    name { "Acme" }
    owner_id { SecureRandom.uuid }
    state { "active" }
  end

  factory :employee do
    id { SecureRandom.uuid }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name } 
    email { Faker::Internet.email }
    department { Faker::Company.industry }
    role { Faker::Company.profession }
  end
end