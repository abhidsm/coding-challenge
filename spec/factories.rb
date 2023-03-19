FactoryBot.define do
  
  factory :project do
    name { "Acme" }
    owner_id { SecureRandom.uuid }
    state { "active" }
  end
end