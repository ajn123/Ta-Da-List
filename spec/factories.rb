# frozen_string_literal: true

FactoryBot.define do
  factory :list_one, class: List do
    title { 'title #1' }
    user { User.create(email: 'bj@gmail.com', password: 'password') }
  end
end
