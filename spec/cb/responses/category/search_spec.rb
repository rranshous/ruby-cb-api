require 'spec_helper'

module Cb
  describe Responses::Category::Search do
    let(:json_hash) do
      Cb::RSpec::Data.for described_class
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        Responses::Category::Search.new(json_hash).class.should eq Responses::Category::Search
      end

      it 'instantiates new model objects' do
        models = Responses::Category::Search.new(json_hash).models

        models.length.should == 4

        models[0].code.should == 'JN001'
        models[0].name.should == 'Accounting'
        models[0].language.should == 'en-US'

        models[1].code.should == 'JN002'
        models[1].name.should == 'Admin - Clerical'
        models[1].language.should == 'en-US'

        models[2].code.should == 'JN054'
        models[2].name.should == 'Automotive'
        models[2].language.should == 'en-US'

        models[3].code.should == 'JN038'
        models[3].name.should == 'Banking'
        models[3].language.should == 'en-US'
      end

    end
  end
end
