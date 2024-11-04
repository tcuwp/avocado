FactoryBot.define do
  sequence(:email_address) { |n| "name#{n}@host.example" }

  factory :event do
    user
    action { "session:create" }
  end

  factory :session do
    user
  end

  factory :user do
    email_address
    password { "Password.12345" }
  end
end
