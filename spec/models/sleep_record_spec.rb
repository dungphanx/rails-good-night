# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'scopes' do
    describe '.ordered_by_created_time' do
      it 'returns sleep records ordered by created time in ascending order' do
        record1 = create(:sleep_record, created_at: 2.days.ago)
        record2 = create(:sleep_record, created_at: 1.day.ago)
        record3 = create(:sleep_record, created_at: Time.current)

        expect(SleepRecord.ordered_by_created_time).to eq([record1, record2, record3])
      end
    end

    describe '.from_previous_week' do
      it 'returns sleep records from the previous week' do
        create(:sleep_record, bed_time: 1.week.ago + 1.hour)
        create(:sleep_record, bed_time: 2.weeks.ago + 1.hour)
        create(:sleep_record, bed_time: Time.current)

        expect(SleepRecord.from_previous_week.count).to eq(2)
      end
    end
  end

  describe '#duration' do
    it 'calculates the duration between bed time and wake up time' do
      sleep_record = create(:sleep_record, bed_time: Time.current - 6.hours, wake_up_time: Time.current)

      expect(sleep_record.duration).to eq(sleep_record.wake_up_time - sleep_record.bed_time)
    end
  end

  describe '.sorted_by_duration' do
    it 'returns sleep records sorted by duration' do
      sleep_record1 = create(:sleep_record, bed_time: Time.current - 8.hours, wake_up_time: Time.current)
      sleep_record2 = create(:sleep_record, bed_time: Time.current - 6.hours, wake_up_time: Time.current)

      expect(SleepRecord.sorted_by_duration).to eq([sleep_record2, sleep_record1])
    end
  end
end
