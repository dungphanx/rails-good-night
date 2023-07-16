# frozen_string_literal: true

Rails.application.routes.draw do
  root to: proc { [200, {}, ['Welcome to Rails Good Night App :)']] }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      resources :sleep_records, only: %i[index create] do
        collection do
          post :track
        end
      end
      resources :follows, only: [:create] do
        collection do
          delete :unfollow
        end
      end
      resources :friend_sleep_records, only: [:show]
    end
  end
end
