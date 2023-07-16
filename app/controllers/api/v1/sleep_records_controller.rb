# frozen_string_literal: true

module Api
  module V1
    class SleepRecordsController < ApiController
      before_action :set_user, except: [:index]

      def index
        sleep_records = SleepRecord.ordered_by_created_time
        render json: sleep_records
      end

      def create
        sleep_record = @user.sleep_records.new(sleep_record_params)

        if sleep_record.save
          render json: sleep_record
        else
          render_400(sleep_record.errors.full_messages)
        end
      end

      def track
        @user.is_sleeping? ? @user.wake_up : @user.go_sleep
        sleep_record = @user.sleep_records.last
        render json: sleep_record
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def sleep_record_params
        params.permit(:bed_time, :wake_up_time)
      end
    end
  end
end
