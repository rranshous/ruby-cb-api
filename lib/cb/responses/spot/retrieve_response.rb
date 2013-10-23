module Cb::Responses
  module Spot
    class Retrieve < ApiResponse

      protected

      def root_node
        'ResponseRetrieve'
      end

      def validate_api_response
        require_response_hash_key root_node,            api_response_hash
        require_response_hash_key spot_collection_node, api_response_hash[root_node]
      end

      def extract_models
        spot_collection.map { |spot_data| Cb::Models::Spot.new(spot_data) }
      end

      private

      def spot_collection
        api_response_hash[root_node][spot_collection_node]
      end

      def spot_collection_node
        'SpotData'
      end

    end
  end
end
