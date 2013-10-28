module Cb

  class Resume
    class Education
      attr_accessor :school_name, :major, :degree_name, :degree_code, :graduation_date, :gpa

      def initialize(args = {})
        @school_name      = args['SchoolName']     || String.new
        @major            = args['Major']          || String.new
        @degree_name      = args['DegreeName']     || String.new
        @degree_code      = args['DegreeCode']     || String.new
        @graduation_date  = args['GraduationDate'] || String.new
        @gpa              = args['GPA']            || String.new
      end
    end
  end

end
