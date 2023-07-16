# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      def index
        users = User.includes(:followers, :sleep_records)
        render json: users, each_serializer: UserSerializer
      end
    end
  end
end
