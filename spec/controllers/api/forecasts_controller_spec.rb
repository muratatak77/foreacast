# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::ForecastsController, type: :controller do
  describe 'GET #index' do
    let(:address) { '12345 Main St, 95035, Milpitas, CA' }
    let(:zip) { '95035' }

    before do
      get :index, params: { address: address, zip: zip }, as: :json
    end

    it 'When is expired or cache is nil - returns http 404' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        ServiceWeatherapiJob.perform_later(zip)
      end.to have_enqueued_job
      expect(response).to have_http_status(404)
    end

    context 'When we have data in cache' do
      before do
        allow(CacheUtil).to receive(:expire?).and_return(false)
        get :index, params: { address: address, zip: zip }, as: :json
      end

      it '200 response' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
