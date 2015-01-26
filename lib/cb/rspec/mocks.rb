require 'cb/rspec/data'

module Cb
  module RSpec
    module Mocks

      def stub_cb_api
        allow_any_instance_of(Cb::Client).to receive(:execute) do |cb_client, cb_request|
          stubbed_cb_response = cb_response cb_request.class

          stubbed_cb_response ? stubbed_cb_response : raise(cb_api_stubbing_error cb_request.class)
        end
      end

      def stub_cb_response(cb_response_class, stub_hash)
        cb_responses_stub_map[cb_response_class] = stub_hash
      end

      def expect_cb_client_to_receive(expected_cb_request)
        expect_any_instance_of(Client).to receive(:execute) do |client, cb_request|
          expect(cb_request.args).to eq expected_cb_request.args

          cb_request_class = cb_request.class

          cb_response cb_request_class
        end
      end

      def allow_cb_client_to_raise(error, cb_request)
        expect_any_instance_of(Client).to receive(:execute).with(kind_of cb_request).and_raise error
      end

      private

      def cb_api_stubbing_error(cb_request_class)
        message = "An attempt to call the CB API using #{ cb_request_class } was made. Stub out the Cb::Client call!"

        StandardError.new message
      end

      def cb_response(cb_request_class)
        cb_response_class = Utils::ResponseMap.response_for cb_request_class
        cb_response_stubbed_json = cb_responses_stub_map[cb_response_class] || {}

        cb_response_class.new Data.for(cb_response_class).merge(cb_response_stubbed_json) rescue nil
      end

      def cb_responses_stub_map
        @cb_responses_stub_map ||= {}
      end

    end
  end
end
