# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleep_records

  has_many :follows
  has_many :following_users, through: :follows, source: :followed_user
  has_many :followers, through: :follows, source: :user
end
