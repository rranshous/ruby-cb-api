module Cb
  class Resume
    class Stats
      attr_accessor :searches, :clicks, :applications


      def initialize(source_hash = {})
        @searches      = source_hash['Searches']     || -1
        @clicks        = source_hash['Clicks']       || -1
        @applications  = source_hash['Applications'] || -1
      end

    end
  end
end
