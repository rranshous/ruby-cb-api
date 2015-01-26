module Cb
  module RSpec
    class Data
      class << self

        def for(cb_response_class)
          JSON.parse File.read(json_data_filepath cb_response_class)
        end

        private

        def json_data_filepath(cb_response_class)
          class_to_filepath = cb_response_class.to_s.snakecase.sub('cb/responses', '')

          File.expand_path(File.dirname __FILE__) + "/data#{ class_to_filepath }.json"
        end

      end
    end
  end
end
