# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    password { Faker::Internet.password(8) }
    password_confirmation { password }
  end

  factory :city do
    name { Faker::Address.city }
    description { Faker::Lorem.sentence }
    population { Faker::Number.number(6) }
  end
end
