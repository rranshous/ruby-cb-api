module Cb

  class Resume
    class CompanyExperience
      attr_accessor :job_title, :company_name, :start_date, :end_date, :is_current, :details

      def initialize(args = {})
        @job_title        = args['JobTitle'] || ''
        @company_name     = args['CompanyName'] || ''
        @start_date       = args['StartDate'] || ''
        @end_date         = args['EndDate'] || ''
        @is_current       = args['IsCurrent'] || ''
        @details          = args['Details'] || ''
      end
    end
  end

end
