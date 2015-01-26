require 'spec_helper'

module Cb
  describe Responses::ApplicationExternal::SubmitApplication do
    let(:json_hash) do
      Cb::RSpec::Data.for described_class
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        Responses::ApplicationExternal::SubmitApplication.new(json_hash).class.should eq Responses::ApplicationExternal::SubmitApplication
      end

      it 'instantiates new model objects' do
        response = Responses::ApplicationExternal::SubmitApplication.new(json_hash)

        response.model.apply_url.should == "website.com"
      end

    end
  end
end