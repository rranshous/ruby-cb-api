module Cb
  class ResumeApi
    class << self

      #############################################################
      ## Retrieve resumes a user owns.
      ##
      ## Returns an array of resumes with external id and
      ## title set.
      ##
      ## Note: This does not load the resume, a subsequent resume
      ## retrieve is required.
      ##
      ## For detailed information around this API please visit:
      ## http://www.careerbuilder.com/api/ResumeInfo.aspx
      #############################################################
      def own_all(external_user_id, ignore_host_site = false)
        new.own_all(external_user_id, ignore_host_site)
      end

      #############################################################
      ## Retrieve the contents of a resume by external id.
      ##
      ## For detailed information around this API please visit:
      ## http://www.careerbuilder.com/api/ResumeInfo.aspx
      #############################################################
      def retrieve_by_id(external_resume_id, external_user_id)
        new.retrieve_by_id(external_resume_id, external_user_id)
      end

      #############################################################
      ## Retrieve the contents of a resume.
      ##
      ## For detailed information around this API please visit:
      ## http://www.careerbuilder.com/api/ResumeInfo.aspx
      #############################################################
      def retrieve(resume)
        new.retrieve(resume)
      end

      #############################################################
      ## TODO: Create a resume
      ##
      ## For detailed information around this API please visit:
      ## http://www.careerbuilder.com/api/ResumeInfo.aspx
      #############################################################
      def create(resume)
        new.create(resume)
      end

      #############################################################
      ## TODO: Update a resume
      ##
      ## For detailed information around this API please visit:
      ## http://www.careerbuilder.com/api/ResumeInfo.aspx
      #############################################################
      def update(resume)
        new.update(resume)
      end

      #############################################################
      ## TODO: Delete a resume
      ##
      ## For detailed information around this API please visit:
      ## http://www.careerbuilder.com/api/ResumeInfo.aspx
      #############################################################
      def delete(resume)
        new.delete(resume)
      end
    end

    def own_all(external_user_id, ignore_host_site = false)
      params = { 'ExternalUserID' => external_user_id }
      params['IgnoreHostSite'] = 'true' if ignore_host_site

      response_hash = api_client.cb_get(Cb.configuration.uri_resume_own_all, :query => params)
      
      resumes = Responses::Resume::OwnAll.new(response_hash).models
      resumes.each { |resume| resume.external_user_id = external_user_id }
      resumes
    end


    def retrieve_by_id external_resume_id, external_user_id
      params = { 'ExternalID' => external_resume_id, 'ExternalUserID' => external_user_id }
      response_hash = api_client.cb_get(Cb.configuration.uri_resume_retrieve, :query => params)

      if response_hash.has_key?('ResponseRetrieve') && response_hash['ResponseRetrieve'].has_key?('Resume')
        resume = Cb::Resume.new response_hash['ResponseRetrieve']['Resume']
        api_client.append_api_responses resume, response_hash['ResponseRetrieve']
      end

      return resume
    end


    def retrieve resume
      my_api = Cb::Utils::Api.new
      params = {"ExternalID" => resume.external_resume_id, "ExternalUserID" => resume.external_user_id}
      response_hash = my_api.cb_get(Cb.configuration.uri_resume_retrieve, :query => params)

      if response_hash.has_key?('ResponseRetrieve') && response_hash['ResponseRetrieve'].has_key?('Resume')
        resume = resume.set_attributes response_hash['ResponseRetrieve']['Resume']
        my_api.append_api_responses resume, response_hash['ResponseRetrieve']
      end

      return resume
    end

    def create(resume)
      api_client.cb_post(Cb.configuration.uri_resume_create, :body => resume.make_create_xml)
    end


    def update(resume)
      api_client.cb_post(Cb.configuration.uri_resume_update, :body => resume.make_update_xml)
    end


    def delete(resume)
      api_client.cb_post(Cb.configuration.uri_resume_delete, :body => resume.make_delete_xml)
    end

    private

    def api_client
      @cb_api_client ||= Cb::Utils::Api.new
    end
  end
end
