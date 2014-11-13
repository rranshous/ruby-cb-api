require_relative '../base'

module Cb
  module Requests
    module DataLists
      class State < Base
        def endpoint_uri
          Cb.configuration.uri_state
        end

        def http_method
          :get
        end

        def query
          {
              :CountryCode => args[:country_code]
          }
        end
      end
    end
  end
end
