require 'spec_helper'

describe Cb::Responses::ResumeList do
  let(:response) { Cb::RSpec::Data.for described_class }

  context 'when the api response comes back as expected' do
    let(:list) { Cb::Responses::ResumeList.new(response) }
    it { expect(list.models.first).to be_an_instance_of Cb::Models::ResumeListing }
  end

  context 'when the Api response is missing the results field' do
    it 'raises an exception' do
      response.delete('Resumes')
      expect{ Cb::Responses::ResumeList.new(response) }.
          to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
        expect(ex.message).to include 'Resumes'
      end
    end
  end
end
