# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sleep_records, only: [:index]
      resources :follows, only: [:create] do
        collection do
          delete :unfollow
        end
      end
      resources :friend_sleep_records, only: [:show]
    end
  end
end
