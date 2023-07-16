# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FriendSleepRecordsController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:following_user1) { create(:user) }
    let(:following_user2) { create(:user) }

    before do
      create(:follow, user:, followed_user: following_user1)
      create(:follow, user:, followed_user: following_user2)
    end

    context 'when user exists' do
      let!(:oldest) do
        create(:sleep_record, user: following_user1, bed_time: 8.days.ago, wake_up_time: 8.days.ago + 8.hours)
      end
      let!(:longest_duration) do
        create(:sleep_record, user: following_user2, bed_time: 3.days.ago, wake_up_time: 3.days.ago + 8.hours)
      end
      let!(:shortest_duration) do
        create(:sleep_record, user: following_user1, bed_time: 3.days.ago, wake_up_time: 3.days.ago + 2.hours)
      end

      it 'returns the friend sleep records from the previous week, sorted by duration' do
        get :show, params: { id: user.id }

        expect(response).to have_http_status(:ok)
        response_ids = JSON.parse(response.body).pluck('id')
        expect(response_ids).to match_array([shortest_duration.id, longest_duration.id])
      end
    end

    context 'when user does not exist' do
      it 'returns an error message' do
        get :show, params: { id: 123 }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq(['Could not find user with id 123'])
      end
    end
  end
end
