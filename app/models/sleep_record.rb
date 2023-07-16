# frozen_string_literal: true

class SleepRecord < ApplicationRecord
  belongs_to :user

  scope :order_by_created_time, -> { order(created_at: :asc) }
end
