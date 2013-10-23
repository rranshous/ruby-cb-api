module Cb
  module Responses
    class ApiResponse

      def self.models(api_output_hash)
        new(api_output_hash).models
      end

      attr_accessor :api_response_hash

      def initialize(api_response_hash={})
        @api_response_hash = api_response_hash
        add_generic_response_info
      end

      def models
        validate_api_response
        extract_models
      end

      def validate_api_response
        # call #required_response_field in here for each node that you know you'll need - stuff like the root node
        # or the node that contains the data from which your model is built.
        raise NotImplementedError.new(__method__)
      end

      protected

      def extract_models
        # your api hash is considered valid at this point - grab the data you need and turn it into model(s)
        raise NotImplementedError.new(__method__)
      end

      def require_response_hash_key(field_name, parent_hash)
        raise ArgumentError.new('field_name cannot be nil!')  if field_name.nil?
        raise ArgumentError.new('parent_hash cannot be nil!') if parent_hash.nil?
        raise ExpectedResponseFieldMissing.new(field_name) unless parent_hash.has_key? field_name
      end

      def root_node
        raise NotImplementedError.new(__method__)
      end

      private

      def add_generic_response_info
        hash_containing_info = api_response_hash.has_key?(root_node) ? api_response_hash[root_node] : api_response_hash
        cb_api_client.append_api_responses(self, hash_containing_info)
      end

      def cb_api_client
        @api_client ||= Cb::Utils::Api.new
      end
    end
  end
end
