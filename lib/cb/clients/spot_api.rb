require 'json'

module Cb
  module ApiClients
    class Spot

      def self.retrieve(criteria)
        new.retrieve(criteria)
      end

      def retrieve(criteria)
        api_hash = retrieve_api_data criteria
        response = Cb::Responses::Spot::Retrieve.new(api_hash)
        response.models
      end

      private

      def retrieve_api_data(criteria)
        params = api_client.class.criteria_to_hash criteria
        api_client.cb_get(Cb.configuration.uri_spot_retrieve, :query => params)
      end

      def api_client
        @api ||= Cb::Utils::Api.new
      end

    end
  end
end
