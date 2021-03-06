module Cb
  module Responses
    class ResumeDataList < ApiResponse

      protected

      def validate_api_hash
        required_response_field('TotalResults', response)
        required_response_field('ReturnedResults', response)
        required_response_field(collection_node, response)
      end

      def hash_containing_metadata
        response['Errors']
      end

      def extract_models
        model_hash.map! { |list_item| Models::ResumeDataList.new(list_item) }
      end

      private

      def collection_node
        'Results'
      end

      def model_hash
        response[collection_node]
      end
    end
  end
end
