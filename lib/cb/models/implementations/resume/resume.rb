module Cb
  class Resume
    attr_accessor :external_resume_id, :external_user_id, :did, :title, :visibility, :resume_text,
                  :email, :real_name, :gender, :phone, :birth_date, :custom_values, :test, :stats,
                  :address, :city, :state, :postal_code, :country_code, :show_contact_info,
                  :created_dt, :modified_dt, :categories, :languages, :company_experiences, :educations

    def initialize(args = {})
      set_attributes(args)
    end

    def set_attributes(args = {})
      return if args.nil?
      @did                      = args['ResumeDID']        || String.new
      @email                    = args['Email']            || String.new
      @real_name                = args['RealName']         || String.new
      @gender                   = args['Gender']           || String.new
      @address                  = args['Address']          || String.new
      @city                     = args['City']             || String.new
      @state                    = args['State']            || String.new
      @postal_code              = args['PostalCode']       || String.new
      @country_code             = args['CountryCode']      || String.new
      @phone                    = args['Phone']            || String.new
      @birth_date               = args['BirthDate']        || String.new
      @title                    = args['Title']            || String.new
      @visibility               = args['Visibility']       || String.new
      @show_contact_info        = args['ShowContactInfo']  || String.new
      @created_dt               = args['CreatedDT']        || String.new
      @modified_dt              = args['ModifiedDT']       || String.new
      @categories               = args['Categories']       || String.new
      @resume_text              = args['ResumeText']       || String.new
      @external_resume_id       = args['ExternalID']       || String.new
      @stats                    = Resume::Stats.new(args['Stats'])
      @external_user_id         = String.new if @external_user_id.blank?
      @test                     = false

      @company_experiences = []
      if args.has_key?('CompanyExperiences') && !args['CompanyExperiences'].blank?
        ce = args['CompanyExperiences']['CompanyExperience']
        if ce.is_a? Array
          ce.each do |hi|
            @company_experiences << Resume::CompanyExperience.new(hi)
          end
        elsif ce.is_a? Hash
          @company_experiences << Resume::CompanyExperience.new(ce)
        end
      end

      @educations = []
      if args.has_key?('Educations') && !args['Educations'].blank?
        ed = args['Educations']['Education']
        if ed.is_a? Array
          ed.each do |hello|
            @educations << Resume::Education.new(hello)
          end
        elsif ed.is_a? Hash
          @educations << Resume::Education.new(ed)
        end
      end

      @languages = []
      if args.has_key?('Languages') && !args['Languages'].blank?
        la = args['Languages']['Language']
        if la.is_a? Array
          la.each do |greetings|
            @languages << Resume::Language.new(greetings)
          end
        elsif la.is_a? String
          @languages << Resume::Language.new(la)
        end
      end

      @custom_values = []
      if args.has_key?('CustomValues') && !args['CustomValues'].blank?
        cv = args['CustomValues']['CustomValue']
        if cv.is_a? Array
          cv.each do | hola |
            @custom_values << Resume::CustomValue.new(hola)
          end
        elsif cv.is_a? Hash
          @custom_values << Resume::CustomValue.new(cv)
        end
      end
    end

    def add_company_experience(params)
      @company_experiences << Resume::CompanyExperience.new(params)
    end

    def add_education(params)
      @educations << Resume::Education.new(params)
    end

    def add_language(params)
      @languages << Resume::Language.new(params)
    end

    def add_custom_value(params)
      @custom_values << Resume::CustomValue.new(params)
    end

    def custom_value desired_key
      value = @custom_values.select { |custom_value| custom_value.key == desired_key }.first
      return String.new if value.nil?
      value
    end

    def current_employed
      custom_value "CURR_EMPLYD"
    end

    def desired_job_type
      custom_value "DES_JOB_TYP"
    end

    def experience_in_months
      custom_value "EXP_MNS"
    end

    def job_type
      custom_value "JOB_TYP"
    end

    def recent_income
      custom_value "RCNT_INCM"
    end

    def recent_income_currency_type
      custom_value "RCNT_INCM_CRCY_TYP"
    end

    def recent_income_type
      custom_value "RCNT_INCM_TYP"
    end

    def it_skill
      custom_value "IT_SKILLS"
    end

    def certifications
      custom_value "CERTS"
    end

    def management_experience
      custom_value "MGMT_EXP"
    end

    def lang_prof(id_lang)
      custom_value "LANG_PROF" + id_lang
    end

    def langs
      custom_value "LANGS"
    end

    def lang(id_lang)
      custom_value "LANG" + id_lang
    end
  end
end
