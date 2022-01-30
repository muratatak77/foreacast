# frozen_string_literal: true

class ServiceWeatherapiJob < ApplicationJob
  queue_as :default

  def perform(zip_code)
    Service::Weatherapi::Api.new(zip_code).start
  end
end
