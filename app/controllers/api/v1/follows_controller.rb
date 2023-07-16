# frozen_string_literal: true

module Api
  module V1
    class FollowsController < ApiController
      before_action :find_users, only: %i[create unfollow]

      def create
        follow = Follow.new(user_id: @user.id, followed_user_id: @followed_user.id)

        if follow.save
          render json: { message: "You are now following #{@followed_user.name}" }
        else
          render_400(follow.errors.full_messages)
        end
      end

      def unfollow
        @user.following_users.delete(@followed_user)
        render json: { message: "You have unfollowed #{@followed_user.name}" }
      end

      private

      def find_users
        @user = User.find_by(id: follow_parameter[:user_id])
        @followed_user = User.find_by(id: follow_parameter[:followed_user_id])

        render_400('Could not detect user or following user.') unless @user && @followed_user
      end

      def follow_parameter
        params.permit(:user_id, :followed_user_id)
      end
    end
  end
end
