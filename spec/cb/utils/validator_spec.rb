require 'spec_helper'

module Cb
  describe ResponseValidator do

    let(:response)          { double(HTTParty::Response) }
    let(:response_property) { double('HTTParty::Response.response') }

    before :each do
      allow(response).to receive(:response).and_return(response_property)
      allow(response).to receive(:code).and_return(200)
    end

    it 'should return empty hash when body is empty' do
       allow(response.response).to receive(:body).and_return(String.new)
       validation = ResponseValidator.validate(response)
       expect(validation.empty?).to be_truthy
    end

    it 'should return empty hash when body is improper json/xml' do
      allow(response.response).to receive(:body).and_return('json')
      validation = ResponseValidator.validate(response)
      expect(validation.empty?).to be_truthy
    end

    it 'should return empty hash when response is nil' do
      response = nil
      validation = ResponseValidator.validate(response)
      expect(validation.empty?).to be_truthy
    end

    it 'should return empty hash when url is invalid' do
      allow(response).to receive(:code).and_return 404
      allow(response.response).to receive(:body).and_return('<!DOCTYPE html></html>')
      validation = ResponseValidator.validate(response)
      expect(validation.empty?).to be_truthy
    end

    it 'should return a full json hash when response status is not 200 and content is json' do
      allow(response.response).to receive(:body).and_return('{"TestJson":{"Test":"True"}}')
      validation = ResponseValidator.validate(response)
      expect(validation.empty?).to be_falsey
    end

    it 'should return a blank json hash when status is not 200 and content is html' do
      allow(response.response).to receive(:body).and_return('<!DOCTYPE html></html>')
      validation = ResponseValidator.validate(response)
      expect(validation.empty?).to be_truthy
    end

    it 'should raise a ServiceUnavailableError when status code is 503' do
      allow(response).to receive(:code).and_return 503
      expect{ ResponseValidator.validate(response) }.to raise_error(Cb::ServiceUnavailableError)
    end

    it 'should raise an UnauthorizedError when status code is 401' do
      allow(response).to receive(:code).and_return(401)
      expect{ ResponseValidator.validate(response) }.to raise_error(Cb::UnauthorizedError)
    end

    context 'when there are JSON parsing errors' do
      context 'and the content payload is not XML' do
        it 'returns an empty hash' do
          allow(response.response).to receive(:body).and_return('yay not json')
          validation = ResponseValidator.validate(response)
          expect(validation).to eq Hash.new
        end
      end

      context 'and the content payload is XML' do
        it 'returns the XML hashified' do
          xml = '<yo><this><isxml>yay</isxml></this></yo>'
          allow(response.response).to receive(:body).and_return(xml)
          validation = ResponseValidator.validate(response)
          expect(validation).to be_an_instance_of Hash
          expect(validation).to eq({"yo"=>{"this"=>{"isxml"=>"yay"}}})
        end

      end
    end

  end
end
