require 'spec_helper'
module Cb
  describe Responses::AnonymousSavedSearch::Create do
    let(:json_hash) do
      Cb::RSpec::Data.for described_class
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        Responses::AnonymousSavedSearch::Create.new(json_hash).class.should eq Responses::AnonymousSavedSearch::Create
      end

      it 'instantiates new model objects' do
        response = Responses::AnonymousSavedSearch::Create.new(json_hash)

        response.model.class.should == Cb::Models::SavedSearch
      end

    end
  end
end