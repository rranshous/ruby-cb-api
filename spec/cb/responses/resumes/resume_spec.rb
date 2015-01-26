require 'spec_helper'

describe Cb::Responses::Resume do
  let(:response) { Cb::RSpec::Data.for described_class }
  let(:resumes) { Cb::Responses::Resume.new(response) }
  context 'when the Api response comes back as expected' do
    it { expect(resumes.models.first).to be_an_instance_of Cb::Models::Resume }
  end

  describe '#status' do
    it { expect(resumes.status).to eq('Success') }
  end

  context 'when the Api response is missing the results field' do
    it 'raises an exception' do
      response.delete('Results')
      expect{ Cb::Responses::Resume.new(response) }.
        to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
          expect(ex.message).to include 'Results'
      end
    end
  end
end
