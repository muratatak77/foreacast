# frozen_string_literal: true

require 'timeout'
require 'net/http'
require 'json'
require 'cache_util'

module Service
  module Weatherapi
    class Base
      def initialize(zip_code)
        @zip_code = zip_code
      end

      def start
        fetch_data
      end

      REQUIRED_OVERRIDES = %i[
        url
        api_key
      ].freeze

      private

      REQUIRED_OVERRIDES.each { |method| define_method(method) { raise NotImplementedError } }

      attr_reader :zip_code

      def fetch_data
        json = fetch_json
        result = represent(json).result
        CacheUtil.update(zip_code, result)
      end

      def fetch_json
        Timeout.timeout(5) do # 5 seconds - operation that may cause a timeout
          uri = URI.parse(api_url)
          http = Net::HTTP.new(uri.host)
          request = Net::HTTP::Get.new(uri.request_uri)
          response = http.request(request)
          Rails.logger.info "Getting response from #{api_url}"
          return JSON.parse(response.body)
        end
      rescue StandardError => e
        raise e.message
      end

      def api_url
        # https://api.weatherapi.com/v1/forecast.json?key=cdebe0fa73fd47458d744038223001&q=95035&days=1&aqi=no&alerts=no
        @api_url ||= "#{url}?key=#{api_key}&q=#{zip_code}&aqi=no&days=1&alerts=no"
      end

      def represent(json)
        @represent ||= Represent.new(json)
      end
    end
  end
end
