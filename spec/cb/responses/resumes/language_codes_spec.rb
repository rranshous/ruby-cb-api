require 'spec_helper'

module Cb
  module Responses
    describe LanguageCodes do
      let(:response_stub) { Cb::RSpec::Data.for described_class }
      let(:response) { Cb::Responses::LanguageCodes.new(response_stub) }

      it { expect(response.models.first).to be_an_instance_of(Cb::Models::LanguageCode) }

      context 'missing node LanguageCodes' do
        before do
          response_stub['ResponseLanguageCodes'].delete('LanguageCodes')
        end
        it do
          expect {Cb::Responses::LanguageCodes.new(response_stub)}.
            to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include 'LanguageCodes'
          end
        end
      end

      context 'missing node LanguageCodes' do
        before do
          response_stub['ResponseLanguageCodes']['LanguageCodes'].delete('LanguageCode')
        end
        it do
          expect {Cb::Responses::LanguageCodes.new(response_stub)}.
              to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include 'LanguageCode'
          end
        end
      end
    end
  end
end
