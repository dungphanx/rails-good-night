# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleep_records

  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :followed_user

  has_many :followings, class_name: 'Follow', foreign_key: :followed_user_id, dependent: :destroy
  has_many :following_users, through: :followings, source: :user
end
