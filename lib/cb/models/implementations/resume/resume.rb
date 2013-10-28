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
      @stats                    = Resume::Stats.new(args['Stats'] || Hash.new)
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

    def make_create_xml
      xml = "<Request>"
      xml += "<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>"
      xml += "<ExternalID>#{external_resume_id}</ExternalID>"
      xml += "<Test>false</Test>"
      xml += "<ExternalUserID>#{user_external_id}</ExternalUserID>"
      cd = self.new_record? ? Date.current : self.created_at
      md = self.new_record? ? Date.current : self.updated_at
      xml += "<CreatedDT>#{cd.xmlschema}</CreatedDT>"
      xml += "<ModifiedDT>#{md.xmlschema}</ModifiedDT>"
      xml += "<Certifications>#{certifications * ','}</Certifications>"
      xml += "<ShowContactInfo>#{show_contact_info}</ShowContactInfo>"
      xml += "<Title>#{title.xmlsafe}</Title>"
      xml += "<ResumeText>#{resume_text.xmlsafe}</ResumeText>"
      xml += "<Visibility>#{visibility.to_s.downcase}</Visibility>"
      xml += "<CanRelocateNationally>#{can_relocate_nationally.to_s.downcase}</CanRelocateNationally>"
      xml += "<CanRelocateInternationally>#{can_relocate_internationally.to_s.downcase}</CanRelocateInternationally>"
      xml += "<TotalYearsExperience>#{total_years_experience.to_i}</TotalYearsExperience>"
      xml += "<HostSite>#{Cb.configuration.host_site}</HostSite>"
      xml += "<DesiredJobTypes>#{desired_job_type}</DesiredJobTypes>" unless desired_job_type.blank?
      xml += "<DesiredJobTypes>ETFE</DesiredJobTypes>" if desired_job_type.blank?
      xml += "<RecentPayAmount>#{recent_pay_amount.money_to_string}</RecentPayAmount>" unless recent_pay_amount.blank?
      xml += "<RecentPayType>#{recent_pay_type.downcase}</RecentPayType>" unless recent_pay_type.blank?

      xml += "<CompanyExperiences>"
      company_experiences.each do |experience|
        xml += "<CompanyExperience>"
        xml += "<CompanyName>#{experience.company_name.xmlsafe}</CompanyName>"
        xml += "<JobTitle>#{experience.job_title.xmlsafe}</JobTitle>"
        xml += "<StartDate>#{experience.start_date.to_s}</StartDate>" unless experience.start_date.blank?
        xml += "<EndDate>#{experience.end_date.to_s}</EndDate>" unless experience.end_date.blank?
        xml += "<EndDate>1970-01-01</EndDate>" if experience.end_date.blank?
        xml += "<Details>#{experience.details.xmlsafe}</Details>"
        xml += "</CompanyExperience>"
      end
      xml += "</CompanyExperiences>"
      xml += "<Educations>"
      educations.each do |education|
        xml += "<Education>"
        xml += "<SchoolName>#{education.school_name.xmlsafe}</SchoolName>"
        xml += "<Major>#{education.major.xmlsafe}</Major>"
        xml += "<DegreeCode>#{education.degree_code}</DegreeCode>"
        xml += "<GraduationDate>#{education.graduation_date.to_s}</GraduationDate>" unless education.graduation_date.blank?
        #Never actually needed:
        #xml += "<GPA>#{education.gpa.to_i}</GPA>"
        xml += "</Education>"
      end
      xml += "</Educations>"
      xml += "<Languages>"
      languages.each do |language|
        xml += "<Language>#{language}</Language>"
      end
      xml += "</Languages>"
      xml += "</Request>"
      xml
    end

    def make_update_xml
      make_create_xml
    end

    def make_delete_xml
      raise "external_resume_id is undefined in CbResume." if resume.external_resume_id.blank?
      raise "external_user_id is undefined in CbResume." if resume.external_user_id.blank?

      xml = '<Request>'
      xml += "<DeveloperKey></DeveloperKey>"
      xml += "<ExternalID>#{resume.external_resume_id}</ExternalID>"
      xml += "<Test>#{resume.test}</Test>"
      xml += "<ExternalUserID>#{resume.external_user_id}</ExternalUserID>"
      xml += '</Request>'
      xml
    end
  end
end
