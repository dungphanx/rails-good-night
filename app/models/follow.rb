# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followed_user, class_name: 'User'

  validates :user_id, uniqueness: { scope: :followed_user_id }
end
