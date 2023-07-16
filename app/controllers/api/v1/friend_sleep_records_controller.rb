# frozen_string_literal: true

module Api
  module V1
    class FriendSleepRecordsController < ApiController
      def show
        user = User.find_by(id: params[:id])
        return render_400("Could not find user with id #{params[:id]}") unless user

        following_ids = user.following_users.pluck(:followed_user_id)
        friend_sleep_records = SleepRecord.where(user_id: following_ids).from_previous_week.sorted_by_duration

        render json: friend_sleep_records
      end
    end
  end
end
