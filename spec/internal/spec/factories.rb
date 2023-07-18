# frozen_string_literal: true

FactoryBot.define do
  sequence(:email) { |n| "name#{n}@host.example" }

  factory :user do
    email
    password { "Password.12345" }
  end
end
