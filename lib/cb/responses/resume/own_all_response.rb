module Cb::Responses
  module Resume
    class OwnAll < ApiResponse

      def validate_api_response
        require_response_hash_key root_node, api_response_hash
        require_response_hash_key collection_node, api_response_hash[root_node]
      end

      def extract_models
        resume_hashes.map { |resume| Cb::Resume.new(resume) }
      end

      protected

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
