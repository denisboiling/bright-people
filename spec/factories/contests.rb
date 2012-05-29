# encoding: utf-8

FactoryGirl.define do
  factory :contest do
    name "Название конкурса"
    started_at (DateTime.now - 1.day)
    ended_at (DateTime.now + 1.day)
  end
end
