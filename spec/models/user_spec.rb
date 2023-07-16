# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:sleep_records) }

    it { is_expected.to have_many(:follows).dependent(:destroy) }
    it { is_expected.to have_many(:following_users).through(:follows).source(:followed_user) }

    it {
      is_expected.to have_many(:followings).class_name('Follow').with_foreign_key(:followed_user_id).dependent(:destroy)
    }
    it { is_expected.to have_many(:followers).through(:followings).source(:user) }
  end
end
