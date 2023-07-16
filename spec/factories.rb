# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "User #{rand(100)}" }
  end

  factory :sleep_record do
    user
    bed_time { 3.days.ago }
    wake_up_time { 3.days.ago + rand(1..12).hours }
  end

  factory :follow do
  end
end
