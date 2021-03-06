require 'spec_helper'

module Cb
  describe Cb::Requests::User::ChangePassword do

    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::User::ChangePassword.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_user_change_password)
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
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID></ExternalID>
              <Test>false</Test>
              <OldPassword></OldPassword>
              <NewPassword></NewPassword>
            </Request>
          eos
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::User::ChangePassword.new({
            external_id: 'external id',
            test: 'true',
            old_password: 'old password',
            new_password: 'new password'
          })
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_user_change_password)
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
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>external id</ExternalID>
              <Test>true</Test>
              <OldPassword>old password</OldPassword>
              <NewPassword>new password</NewPassword>
            </Request>
          eos
        end
      end
    end

  end
end
