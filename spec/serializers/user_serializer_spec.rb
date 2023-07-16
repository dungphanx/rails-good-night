# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let(:user) { create(:user) }
  let!(:sleep_records) { create_list(:sleep_record, 3, user: user) }
  let!(:followers) { create_list(:user, 2) }

  subject { described_class.new(user) }

  describe '#sleep_records' do
    it 'returns an array of serialized sleep records' do
      serialized_sleep_records = subject.sleep_records

      expect(serialized_sleep_records).to be_an(Array)
      expect(serialized_sleep_records.size).to eq(3)

      serialized_sleep_records.each_with_index do |serialized_record, index|
        sleep_record = sleep_records[index]

        expect(serialized_record[:id]).to eq(sleep_record.id)
        expect(serialized_record[:bed_time]).to eq(sleep_record.bed_time)
        expect(serialized_record[:wake_up_time]).to eq(sleep_record.wake_up_time)
      end
    end
  end

  describe '#followers' do
    before do
      user.followers << followers
    end

    it 'returns an array of serialized followers' do
      serialized_followers = subject.followers

      expect(serialized_followers).to be_an(Array)
      expect(serialized_followers.size).to eq(2)

      serialized_followers.each_with_index do |serialized_follower, index|
        follower = followers[index]

        expect(serialized_follower[:id]).to eq(follower.id)
        expect(serialized_follower[:name]).to eq(follower.name)
      end
    end
  end

  describe 'serialized attributes' do
    it 'includes the correct attributes' do
      expect(subject.serializable_hash).to include(
        id: user.id,
        name: user.name,
        sleep_records: subject.sleep_records,
        followers: subject.followers
      )
    end
  end
end
