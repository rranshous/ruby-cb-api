require 'spec_helper'

module Cb
  describe Responses::WorkStatus::List do
    let(:json_hash) do
      Cb::RSpec::Data.for described_class
    end

    describe '#new' do
      let(:response) { Responses::WorkStatus::List.new json_hash }

      it 'returns a Responses::WorkStatus::List object' do
        expect(response).to be_a Responses::WorkStatus::List
      end

      context 'created models' do
        let(:models) { response.models }

        it 'creates Cb::Models::WorkStatus models' do
          models.each { |model| expect(model).to be_a Models::WorkStatus }
        end

        it 'creates one model' do
          expect(models.length).to eq 1
        end

        context 'created model' do
          let(:model) { models[0] }

          it 'assigns key to the model' do
            expect(model.key).to eq 'CTCT'
          end

          context 'created translations' do
            let(:translations) { model.translations }

            shared_examples_for 'a translation' do
              it 'should be a Models::WorkStatus::Translation' do
                expect(translation).to be_a Models::WorkStatus::Translation
              end

              it 'assigns language' do
                expect(translation.language).to eq language
              end

              it 'assigns value' do
                expect(translation.value).to eq value
              end
            end

            context 'first created translation' do
              let(:translation) { translations[0] }
              let(:language) { 'French' }
              let(:value) { 'Citoyen' }

              it_behaves_like 'a translation'
            end

            context 'first created translation' do
              let(:translation) { translations[1] }
              let(:language) { 'Dutch' }
              let(:value) { 'Inwoner' }

              it_behaves_like 'a translation'
            end

            context 'first created translation' do
              let(:translation) { translations[2] }
              let(:language) { 'English' }
              let(:value) { 'US Citizen' }

              it_behaves_like 'a translation'
            end
          end
        end
      end
    end
  end
end
