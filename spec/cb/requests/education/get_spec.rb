require 'spec_helper'

module Cb
  describe Cb::Requests::Education::Get do

    describe '#new' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::Education::Get.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq Cb.configuration.uri_education_code
          expect(@request.http_method).to eq :get
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq ({CountryCode: nil})
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq nil
        end

        it 'should have a basic body' do
          expect(@request.body).to eq nil
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::Education::Get.new({
            country_code: 'Hello'
          })
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq Cb.configuration.uri_education_code
          expect(@request.http_method).to eq :get
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq ({CountryCode: "Hello"})
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq nil
        end

        it 'should have a basic body' do
          expect(@request.body).to eq nil
        end
      end
    end
  end
end
