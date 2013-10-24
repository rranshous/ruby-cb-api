module Cb
  class Resume
    class Stats < ApiResponseModel
      attr_accessor :searches, :clicks, :applications

      protected

      def required_fields
        %w(Searches Clicks Applications)
      end

      def set_model_properties
        @searches      = source_hash['Searches']     || -1
        @clicks        = source_hash['Clicks']       || -1
        @applications  = source_hash['Applications'] || -1
      end

    end
  end
end
