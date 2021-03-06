module Cb
  module Models
    class ResumeDataList < ApiResponseModel
      attr_accessor :key, :value

      def set_model_properties
        @key = api_response['key']
        @value = api_response['value']
      end

      def required_fields
        ['key', 'value']
      end
    end
  end
end
