# frozen_string_literal: true

module Api
  module V1
    class SleepRecordsController < ApplicationController
      def index
        sleep_records = SleepRecord.ordered_by_created_time
        render json: sleep_records
      end
    end
  end
end
