# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    def render_error(messages, http_code)
      error_messages = messages.instance_of?(Array) ? messages : [messages]
      render json: { message: error_messages }, status: http_code
    end

    def render_400(messages)
      render_error(messages, 400)
    end
  end
end
