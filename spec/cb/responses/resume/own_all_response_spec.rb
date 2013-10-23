require 'spec_helper'

describe Cb::Responses::Resume::OwnAll do
  describe '#new' do
    it 'produces the appropriate type' do
      expect(Cb::Responses::Resume::OwnAll.new).to be_an_instance_of Cb::Responses::Resume::OwnAll
    end
  end

  describe '#models' do
    context 'when the API hash is correct' do
      let(:api_hash) do
        { 'ResponseOwnResumes' => { 'Resumes' => { 'Resume' => [Hash.new] } } }
      end

      it 'returns an array' do
        response = Cb::Responses::Resume::OwnAll.new(api_hash)
        expect(response.models).to be_an_instance_of Array
      end

      it 'returned array contains resume models' do
        response = Cb::Responses::Resume::OwnAll.new(api_hash)
        expect(response.models.first).to be_an_instance_of Cb::Resume
      end
    end

    context 'when the API hash is missing nodes' do
      def self.expect_missing_field_exception
        it 'raises an exception for the missing node' do
          response = Cb::Responses::Resume::OwnAll.new(api_hash)
          expect { response.models }.to raise_error Cb::ExpectedResponseFieldMissing
        end
      end

      context '\ResponseOwnResumes' do
        let(:api_hash) { Hash.new }
        expect_missing_field_exception
      end

      context '\ResponseOwnResumes\Resumes' do
        let(:api_hash) do
          { 'ResponseOwnResumes' => Hash.new }
        end
        expect_missing_field_exception
      end

      context '\ResponseOwnResumes\Resumes\Resume' do
        let(:api_hash) do
          { 'ResponseOwnResumes' => { 'Resumes' => Hash.new } }
        end
        expect_missing_field_exception
      end
    end
  end
end
