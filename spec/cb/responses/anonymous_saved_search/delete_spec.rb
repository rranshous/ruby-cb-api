require 'spec_helper'
module Cb
  describe Responses::AnonymousSavedSearch::Delete do
    let(:json_hash) do
      Cb::RSpec::Data.for described_class
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        Responses::AnonymousSavedSearch::Delete.new(json_hash).class.should eq Responses::AnonymousSavedSearch::Delete
      end

      it 'instantiates new model objects' do
        response = Responses::AnonymousSavedSearch::Delete.new(json_hash)

        response.response["Status"].should == 'yay'
      end

    end
  end
end