module Cb::Models
  class Spot < ApiResponseModel

    attr_accessor :content_type, :start_date, :end_date, :sequence, :language, :experiment_weight_custom_column,
                  :field_1, :field_2, :field_3, :field_4, :field_5, :field_6, :field_7, :field_8,
                  :text_1, :text_2, :text_3, :text_4

    def initialize(response={})
      super(response)
    end

    private

    def required_fields
      %w(ContentType StartDate EndDate Sequence Language)
    end

    def set_model_properties
      @content_type                     = source_hash['ContentType']                  || String.new
      @start_date                       = source_hash['StartDate']                    || String.new
      @end_date                         = source_hash['EndDate']                      || String.new
      @sequence                         = source_hash['Sequence']                     || String.new
      @language                         = source_hash['Language']                     || String.new
      @experiment_weight_custom_value   = source_hash['ExperimentWeightCustomValue']  || String.new

      # meta programming the @field_# and @text_# variables => ruby swag
      (1..8).each { |num| instance_variable_set("@field_#{num.to_s}", source_hash["Field#{num.to_s}"] || String.new) }
      (1..4).each { |num| instance_variable_set("@text_#{num.to_s}",  source_hash["Text#{num.to_s}"]  || String.new) }
    end

  end
end
