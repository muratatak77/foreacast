require 'rails_helper'

RSpec.describe Service::Weatherapi::Base do
  subject { described_class.new(zip_code) }

  let(:api_key) { ENV.fetch('WEATHERAPI_API_KEY') }
  let(:url) { ENV.fetch('WEATHERAPI_API_MAIN_URL') }
  let(:zip_code) { '95035'}

  context 'when required methods are not overwritten' do
    %i[
      api_key
      url
    ].each do |method|
      it "raises not implemented error for #{method}" do
        expect { subject.send(method) }.to raise_error(NotImplementedError)
      end
    end
  end

  context 'When to call an api and fetch data' do
    let(:fetch_json_data) {
      JSON.parse(File.read('spec/lib/service/weatherapi/fetch_data.json'))
    }

    let(:result_data){
      JSON.parse(File.read('spec/lib/service/weatherapi/result_data.json'), symbolize_names: true)
    }
    
    before do
      allow(subject).to receive(:fetch_json).and_return(fetch_json_data)
    end

    it 'call api and getting JSON data' do 
      expect(subject.start).to eq result_data
    end

  end

end
