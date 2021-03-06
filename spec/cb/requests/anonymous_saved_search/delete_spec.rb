require 'spec_helper'

module Cb
  describe Cb::Requests::AnonymousSavedSearch::Delete do

    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::AnonymousSavedSearch::Delete.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_anon_saved_search_delete)
          expect(@request.http_method).to eq(:post)
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq(nil)
        end

        it 'should have a basic body' do
          expect(@request.body).to eq <<-eos
          <Request>
            <ExternalID></ExternalID>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <Test>false</Test>
          </Request>
          eos
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::AnonymousSavedSearch::Delete.new({
            external_id: 'external id',
            test: 'true',
          })
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_anon_saved_search_delete)
          expect(@request.http_method).to eq(:post)
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq(nil)
        end

        it 'should have a basic body' do
          expect(@request.body).to eq <<-eos
          <Request>
            <ExternalID>external id</ExternalID>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <Test>true</Test>
          </Request>
          eos
        end
      end
    end

  end
end
