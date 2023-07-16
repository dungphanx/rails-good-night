# frozen_string_literal: true

class AddUniqueIndexToFollow < ActiveRecord::Migration[7.0]
  def change
    add_index :follows, [:user_id, :followed_user_id], unique: true
  end
end
