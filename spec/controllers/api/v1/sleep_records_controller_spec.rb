# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SleepRecordsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns the sleep records ordered by created time' do
      sleep_record1 = create(:sleep_record)
      sleep_record2 = create(:sleep_record)

      get :index
      expect(response).to be_successful

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(2)
      expect(parsed_response.first['id']).to eq(sleep_record1.id)
      expect(parsed_response.last['id']).to eq(sleep_record2.id)
    end
  end

  describe 'POST create' do
    let(:user) { create(:user) }

    context 'with valid parameters' do
      let(:valid_params) { { user_id: user.id, bed_time: Time.zone.now, wake_up_time: Time.zone.now + 8.hours } }

      it 'creates a new sleep record' do
        expect do
          post :create, params: valid_params
        end.to change(SleepRecord, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { user_id: user.id } }

      it 'returns an error message' do
        post :create, params: invalid_params

        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({ 'message' => ["Bed time can't be blank"] })
      end
    end
  end

  describe 'POST track' do
    let(:user) { create(:user) }

    context 'when user is sleeping' do
      before { user.go_sleep }

      it 'wakes up the user and returns the sleep record' do
        expect do
          post :track, params: { user_id: user.id }
        end.not_to change(user.sleep_records, :count)

        expect(response).to have_http_status(:success)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq(user.id)
        expect(parsed_response['name']).to eq(user.name)
        expect(parsed_response['sleep_records']).not_to be_empty
      end
    end

    context 'when user is awake' do
      it 'puts the user to sleep and returns the sleep record' do
        expect do
          post :track, params: { user_id: user.id }
        end.to change(user.sleep_records, :count).by(1)

        expect(response).to have_http_status(:success)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq(user.id)
        expect(parsed_response['name']).to eq(user.name)
        expect(parsed_response['sleep_records']).not_to be_empty
      end
    end
  end
end
