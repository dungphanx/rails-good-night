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

  describe '#is_sleeping?' do
    context 'when the user has no sleep records' do
      let(:user) { create(:user) }

      it 'returns false' do
        expect(user.is_sleeping?).to be_falsey
      end
    end

    context 'when the user has sleep records' do
      let(:user) { create(:user) }
      let!(:sleep_record) { create(:sleep_record, user:, wake_up_time: nil) }

      it 'returns true if the last sleep record has no wake up time' do
        expect(user.is_sleeping?).to be_truthy
      end

      it 'returns false if the last sleep record has a wake up time' do
        sleep_record.update(wake_up_time: Time.zone.now)

        expect(user.is_sleeping?).to be_falsey
      end
    end
  end

  describe '#go_sleep' do
    let(:user) { create(:user) }

    it 'creates a new sleep record with the current bed time' do
      expect do
        user.go_sleep
      end.to change(user.sleep_records, :count).by(1)

      sleep_record = user.sleep_records.last
      expect(sleep_record.bed_time).to be_within(1.second).of(Time.zone.now)
      expect(sleep_record.wake_up_time).to be_nil
    end
  end

  describe '#wake_up' do
    let(:user) { create(:user) }
    let!(:sleep_record) { create(:sleep_record, user:) }

    it 'updates the wake up time of the last sleep record with the current time' do
      expect do
        user.wake_up
      end.to(change { sleep_record.reload.wake_up_time })

      expect(sleep_record.wake_up_time).to be_within(1.second).of(Time.zone.now)
    end
  end
end
