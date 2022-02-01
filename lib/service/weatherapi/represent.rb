# frozen_string_literal: true

module Service
  module Weatherapi
    class Represent
      attr_accessor :result

      def initialize(origin)
        @origin = origin
        @result = adjust_data
      end

      private

      attr_reader :origin

      def adjust_data
        obj = {}
        obj[:location] = set_location
        obj[:current] = current_data
        obj[:max_min] = max_min
        obj[:hours] = extendent
        obj
      end

      def set_location
        obj = {}
        obj[:name] = location['name']
        obj[:region] = location['region']
        obj
      end

      def current_data
        obj = {}
        obj[:temp_f] = current['temp_f'] || nil
        obj[:last_updated] = current['last_updated'] || nil
        obj
      end

      def max_min
        obj = {}
        obj[:maxtemp_f] = day['maxtemp_f']
        obj[:mintemp_f] = day['mintemp_f']
        obj
      end

      def extendent
        res = []
        hours.each do |hour|
          temp = {}
          temp[:time_epoch] = hour['time_epoch']
          temp[:time] =  hour['time']
          temp[:temp_f] = hour['temp_f']
          res << temp
        end
        res
      end

      def day
        @day ||= origin.dig('forecast', 'forecastday', 0, 'day')
      end

      def hours
        @hours ||= origin.dig('forecast', 'forecastday', 0, 'hour')
      end
      
      def location
        @location ||= origin.dig('location')
      end

      def current
        @current ||= origin['current']
      end

    end
  end
end
