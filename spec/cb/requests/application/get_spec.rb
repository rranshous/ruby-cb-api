require 'spec_helper'

module Cb
  describe Cb::Requests::Application::Get do

    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::Application::Get.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_application.sub(':did', ''))
          expect(@request.http_method).to eq(:get)
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq({
            'DeveloperKey' => Cb.configuration.dev_key,
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json'
          })
        end

        it 'should have a basic body' do
          expect(@request.body).to eq(nil)
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::Application::Get.new({
            did: 'app did'
          })
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_application.sub(':did', 'app did'))
          expect(@request.http_method).to eq(:get)
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq({
            'DeveloperKey' => Cb.configuration.dev_key,
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json'
          })
        end

        it 'should have a basic body' do
          expect(@request.body).to eq(nil)
        end
      end
    end

  end
end
