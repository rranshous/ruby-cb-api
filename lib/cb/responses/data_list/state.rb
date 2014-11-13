module Cb
  module Responses
    class State < ApiResponse

      protected
      def validate_api_hash
        required_response_field(StateId, response[0])
        required_response_field(StateName, response[0])
      end

      def hash_containing_metadata
        response
      end

      def extract_models
        response.map! { |state| Models::State.new({ 'state_id' => state.StateId, 'state_name' => state.StateName }) }
      end
    end
  end
end

