
require 'spec_helper'

module Cb
  describe Responses::Company::Find do
    let(:json_hash) do
      Cb::RSpec::Data.for described_class
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        Responses::Company::Find.new(json_hash).class.should eq Responses::Company::Find
      end

      it 'instantiates new model objects' do
        response = Responses::Company::Find.new(json_hash)

        expect(response.model).to be_a Cb::Models::Company
      end

    end
  end
end