module Cb::Responses
  module Resume
    class OwnAll < RawApiResponse

      ROOT_NODE       = 'ResponseOwnResumes'
      COLLECTION_NODE = 'Resumes'
      MODEL_NODE      = 'Resume'

      def self.extract_models(api_output_hash)
        new(api_output_hash).extract_models
      end

      def validate_raw_api_response
        required_response_field ROOT_NODE, raw_api_hash
        required_response_field COLLECTION_NODE, raw_api_hash[ROOT_NODE]
      end

      def extract_models
        resumes = resume_hashes.map { |resume| Cb::CbResume.new(resume) }
        Cb::Utils::Api.new.append_api_responses(resumes, raw_api_hash[ROOT_NODE])
      end

      private

      def resume_hashes
        raw_api_hash[ROOT_NODE][COLLECTION_NODE][MODEL_NODE]
      end

    end
  end
end
