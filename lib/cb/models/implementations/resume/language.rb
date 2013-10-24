module Cb

  class Resume
    class Language
      attr_accessor :name

      def initialize(code = '')
        @name = code
      end
    end
  end

end
