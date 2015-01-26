require 'spec_helper'

module Cb
  describe Responses::Education::Get do
    let(:json_hash) do
      Cb::RSpec::Data.for described_class
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        Responses::Education::Get.new(json_hash).class.should eq Responses::Education::Get
      end

      it 'instantiates new model objects' do
        models = Responses::Education::Get.new(json_hash).models

        models[0].class.should == Cb::Models::Education

        models.length.should == 3

        models[0].code.should == 'DRNS'
        models[0].text.should == 'Not Specified'
        models[0].language.should == 'en-US'

        models[1].code.should == 'DR3210'
        models[1].text.should == 'None'
        models[1].language.should == 'en-US'

        models[2].code.should == 'DR3211'
        models[2].text.should == 'High School'
        models[2].language.should == 'en-US'
      end

    end
  end
end
