module Cb
  module Models
    module DataLists
      class State < ApiResponseModel
        attr_accessor :state_id, :state_name

        def set_model_properties
          @state_id = api_response['@state_id']
          @state_name = api_response['state_name']
        end

        def required_fields
          ['state_id', 'state_name']
        end
      end
    end
  end
end