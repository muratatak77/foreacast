# frozen_string_literal: true

module Api
  class ForecastsController < ApplicationController
    def index
      address = params[:address]
      check_params(address)
      zip = params[:zip]
      zip ||= zip_code(address)
      if CacheUtil.expire?(zip)
        ServiceWeatherapiJob.perform_later(zip)
        render json: 'Data is expired , please try again in a 5 seconds!', status: 404
      else
        render json: CacheUtil.fetch_data(zip), status: 200
      end
    end

    private

    def check_params(address)
      render json: 'Address is missing , please fill address', status: 404 and return unless address
    end

    def zip_code(address)
      @zip_code ||= StreetAddress::US.parse(address)&.postal_code
    end
  end
end
