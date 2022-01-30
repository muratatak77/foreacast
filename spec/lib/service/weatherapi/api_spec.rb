require 'rails_helper'

RSpec.describe Service::Weatherapi::Api do
  let(:api_key) { ENV.fetch('WEATHERAPI_API_KEY') }
  let(:url) { ENV.fetch('WEATHERAPI_API_MAIN_URL') }
  # it_behaves_like 'fetch json data'
end

