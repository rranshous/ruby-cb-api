module Cb

  class Resume
    class Education
      attr_accessor :school_name, :major, :degree_name, :degree_code, :graduation_date, :gpa

      def initialize(args = {})
        @school_name      = args['SchoolName'] || ''
        @major            = args['Major'] || ''
        @degree_name      = args['DegreeName'] || ''
        @degree_code      = args['DegreeCode'] || ''
        @graduation_date  = args['GraduationDate'] || ''
        @gpa              = args['GPA'] || ''
      end
    end
  end

end
