# frozen_string_literal: true

FactoryBot.define do
  sequence(:email) { |n| "name#{n}@host.example" }

  factory :session do
    user
  end

  factory :user do
    email
    password { "Password.12345" }
  end
end
