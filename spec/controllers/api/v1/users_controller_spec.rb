# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET index' do
    it 'returns a JSON response with users and their attributes' do
      user1 = create(:user)
      user2 = create(:user)

      get :index

      expect(response).to have_http_status(:success)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to be_an(Array)
      expect(parsed_response.length).to eq(2)

      user_attributes1 = parsed_response[0]
      user_attributes2 = parsed_response[1]

      expect(user_attributes1['id']).to eq(user1.id)
      expect(user_attributes1['name']).to eq(user1.name)
      expect(user_attributes1['sleep_records']).to eq(user1.sleep_records)
      expect(user_attributes1['followers']).to eq(user1.followers)

      expect(user_attributes2['id']).to eq(user2.id)
      expect(user_attributes2['name']).to eq(user2.name)
      expect(user_attributes2['sleep_records']).to eq(user2.sleep_records)
      expect(user_attributes2['followers']).to eq(user2.followers)
    end
  end
end
