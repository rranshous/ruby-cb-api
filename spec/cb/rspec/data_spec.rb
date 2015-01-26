require 'spec_helper'
require 'cb/rspec/data'

module Cb
  module RSpec
    describe Data do
      describe '#for' do
        subject { described_class.for cb_response_class }

        context 'for supported responses' do
          before do
            allow(File).to receive(:read).and_return file
            allow(JSON).to receive(:parse).and_return parsed_json
          end

          let(:file) { 'File' }
          let(:parsed_json) { 'Hello, I am parsed JSON.' }
          let(:cb_response_class) { Cb::Responses::Resume }
          
          let(:expected_filepath) do
            data_filepath = cb_response_class.to_s.snakecase.sub('cb/responses', '')

            File.expand_path(File.dirname __FILE__).sub('/spec', '/lib') + "/data#{ data_filepath }.json"
          end

          it { is_expected.to eq parsed_json }
          it { expect(File).to receive(:read).with(expected_filepath) }
          it { expect(JSON).to receive(:parse).with(file) }

          after { subject }
        end

        context 'for unsupported responses' do
          let(:cb_response_class) { Cb::Responses::ApiResponse }

          it { is_expected.to eq nil }
        end
      end
    end
  end
end
