module Cb

  class Resume
    class CompanyExperience
      attr_accessor :job_title, :company_name, :start_date, :end_date, :is_current, :details

      def initialize(args = {})
        @job_title        = args['JobTitle']    || String.new
        @company_name     = args['CompanyName'] || String.new
        @start_date       = args['StartDate']   || String.new
        @end_date         = args['EndDate']     || String.new
        @is_current       = args['IsCurrent']   || String.new
        @details          = args['Details']     || String.new
      end
    end
  end

end
