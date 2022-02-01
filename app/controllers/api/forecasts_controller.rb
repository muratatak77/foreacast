# frozen_string_literal: true

module Api
  class ForecastsController < ApplicationController
    def index
      address = params[:address]
      unless address.present?
        render json: { message: 'Address is missing , please fill address!', status: 400 }, status: 400 and return
      end

      zip = params[:zip]
      zip ||= zip_code(address)
      unless zip.present?
        render json: { message: 'Address is not usefull for USA, please fill again address!', status: 400 },
               status: 400 and return
      end

      if CacheUtil.expire?(zip)
        ServiceWeatherapiJob.perform_later(zip)
        render json: {
          message: 'Data is expired , please try again in a few seconds!',
          status: 400
        }, status: 400
      else
        render json: CacheUtil.fetch_data(zip), status: 200
      end
    end

    private

    def zip_code(address)
      @zip_code ||= StreetAddress::US.parse(address)&.postal_code
    end
  end
end
