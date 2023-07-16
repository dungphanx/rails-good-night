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
end
