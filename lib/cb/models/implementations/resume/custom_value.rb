module Cb

  class Resume
    class CustomValue
      attr_accessor :key, :value

      def initialize(args = {})
        @key              = args['Key'] || ''
        @value            = args['Value'] || ''
      end
    end
  end

end
