# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleep_records

  has_many :follows, dependent: :destroy
  has_many :following_users, through: :follows, source: :followed_user

  has_many :followings, class_name: 'Follow', foreign_key: :followed_user_id, dependent: :destroy
  has_many :followers, through: :followings, source: :user

  def is_sleeping?
    return false if sleep_records.empty?

    sleep_records.last.wake_up_time.nil?
  end

  def go_sleep
    sleep_records.create(bed_time: Time.zone.now)
  end

  def wake_up
    sleep_records.last.update!(wake_up_time: Time.zone.now)
  end
end
