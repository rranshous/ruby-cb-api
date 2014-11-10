module Cb
  module Models
    module JobReport
      class ApplicantInfo < ApiResponseModel
        attr_accessor :date_application_viewed, :date_applied, :user_attached_cover_letter, :user_current_salary,
                      :user_education_level

        def set_model_properties
          @date_application_viewed        = api_response['DateApplicationViewed']  || String.new
          @date_applied                   = api_response['DateApplied']            || String.new
          @user_attached_cover_letter     = api_response['CoverLetterAttached']    || String.new
          @user_current_salary            = api_response['UserCurrentSalary']      || String.new
        end

        def required_fields
          ['ApplicantInformation']
        end
      end
    end
  end
end