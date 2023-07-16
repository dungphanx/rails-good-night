# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:sleep_records) }
    it { is_expected.to have_many(:follows) }
    it { is_expected.to have_many(:following_users) }
    it { is_expected.to have_many(:followers) }
  end
end
