# frozen_string_literal: true

class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :bed_time, presence: true

  scope :ordered_by_created_time, -> { order(created_at: :asc) }
  scope :from_previous_week, -> { where('bed_time > ?', 1.week.ago.beginning_of_day) }

  def self.sorted_by_duration
    all.sort_by(&:duration)
  end

  def duration
    wake_up_time - bed_time
  end
end
