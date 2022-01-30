# frozen_string_literal: true

module Service
  module Weatherapi
    class Api < Base
      private

      def api_key
        ENV.fetch('WEATHERAPI_API_KEY')
      end

      def url
        ENV.fetch('WEATHERAPI_API_MAIN_URL')
      end
    end
  end
end
