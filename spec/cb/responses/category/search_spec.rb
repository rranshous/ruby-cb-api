require 'spec_helper'

module Cb
  describe Responses::Category::Search do
    let(:json_hash) do
      {
        "ResponseCategories" =>
          {"Errors" => nil,
           "CountryCode" => "US",
           "TimeResponseSent" => "5/30/2014 11:14:59 AM",
           "Categories" =>
             {"Category" => [
               {
                "Code" => "JN001",
                "Name" => {
                 "@language" => "en-US",
                 "#text" => "Accounting"
                }},
              {
                "Code" => "JN002",
                "Name" =>
                  {
                    "@language" => "en-US",
                    "#text" => "Admin - Clerical"
                }},
              {
                "Code" => "JN054",
                "Name" =>
                  {
                    "@language" => "en-US",
                    "#text" => "Automotive"
                }},
              {
                "Code" => "JN038",
                "Name" =>
                  {
                    "@language" => "en-US",
                    "#text" => "Banking"
                }}]
             }
          }
      }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        expect(Responses::Category::Search.new(json_hash).class).to eq Responses::Category::Search
      end

      it 'instantiates new model objects' do
        models = Responses::Category::Search.new(json_hash).models

        expect(models.length).to eq(4)

        expect(models[0].code).to eq('JN001')
        expect(models[0].name).to eq('Accounting')
        expect(models[0].language).to eq('en-US')

        expect(models[1].code).to eq('JN002')
        expect(models[1].name).to eq('Admin - Clerical')
        expect(models[1].language).to eq('en-US')

        expect(models[2].code).to eq('JN054')
        expect(models[2].name).to eq('Automotive')
        expect(models[2].language).to eq('en-US')

        expect(models[3].code).to eq('JN038')
        expect(models[3].name).to eq('Banking')
        expect(models[3].language).to eq('en-US')
      end

    end
  end
end
