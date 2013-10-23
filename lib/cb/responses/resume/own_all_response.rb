module Cb::Responses
  module Resume
    class OwnAll < ApiResponse

      def initialize(api_response_hash={}, user_external_id)
        super(api_response_hash)
        @user_external_id = user_external_id
      end

      def validate_api_response
        require_response_hash_key root_node,       api_response_hash
        require_response_hash_key collection_node, api_response_hash[root_node]
        require_response_hash_key model_node,      api_response_hash[root_node][collection_node]
      end

      protected

      def extract_models
        resume_hashes.map do |resume|
          resume = Cb::Resume.new(resume)
          resume.external_user_id = @user_external_id
          resume
        end
      end

      def root_node
        'ResponseOwnResumes'
      end

      private

      def resume_hashes
        api_response_hash[root_node][collection_node][model_node]
      end

      def collection_node
        'Resumes'
      end

      def model_node
        'Resume'
      end

    end
  end
end
