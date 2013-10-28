module Cb

  class Resume
    class CustomValue
      attr_accessor :key, :value

      def initialize(args = {})
        @key              = args['Key']   || String.new
        @value            = args['Value'] || String.new
      end
    end
  end

end
