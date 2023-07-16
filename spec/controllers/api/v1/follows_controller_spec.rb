# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FollowsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:followed_user) { create(:user) }

    context 'when valid parameters are provided' do
      it 'creates a new follow record' do
        post :create, params: { user_id: user.id, followed_user_id: followed_user.id }
        expect(response).to have_http_status(:success)
        expect(Follow.count).to eq(1)
        expect(user.following_users).to include(followed_user)
      end

      it 'returns a success message' do
        post :create, params: { user_id: user.id, followed_user_id: followed_user.id }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq("You are now following #{followed_user.name}")
      end
    end

    context 'when invalid parameters are provided' do
      it 'returns a bad request error' do
        post :create, params: { user_id: user.id, followed_user_id: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE #unfollow' do
    let(:user) { create(:user) }
    let(:followed_user) { create(:user) }

    before do
      user.following_users << followed_user
    end

    it 'deletes the follow record' do
      delete :unfollow, params: { user_id: user.id, followed_user_id: followed_user.id }
      expect(response).to have_http_status(:success)
      expect(user.following_users).not_to include(followed_user)
    end

    it 'returns a success message' do
      delete :unfollow, params: { user_id: user.id, followed_user_id: followed_user.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']).to eq("You have unfollowed #{followed_user.name}")
    end
  end
end