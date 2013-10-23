require 'spec_helper'

module Cb
  # this class is meant to be inherited, not directly instantiated! therefore behavior
  # is demonstrated below using dummy implementations.
  describe Cb::Responses::ApiResponse do

    describe '#new' do

      context 'when the inheriting class overrides the required methods' do

        class ValidDummyRawResponse < Cb::Responses::ApiResponse
          def validate_api_response
            require_response_hash_key 'bananas', api_response_hash
          end

          def extract_models
            api_response_hash['bananas']
          end

          def root_node
            'bananas'
          end
        end

        before :each do
          @hash = { 'bananas' => { 'data' => 'b-a-n-a-n-a-s' } }
          @response = ValidDummyRawResponse.new(@hash)
        end

        it 'the raw API hash is accessible via a protected method' do
          method_name = :api_response_hash
          @response.send(method_name).should eq @hash
        end

        context 'and the underlying API hash has all of the required fields' do
          it '#models throws no error since everything is hunky dory' do
            @response.models
          end
        end

        context 'but #require_response_field is used in funky ways' do
          def assert_argument_error(message_fragment)
            begin
              @response.send(:require_response_hash_key, @field_name, @parent_hash)
            rescue ArgumentError => ex
              ex.message.include?(message_fragment).should eq true
            end
          end

          it 'argument 1 of 2 cannot be nil' do
            @field_name = nil
            @parent_hash = Hash.new
            assert_argument_error 'field_name'
          end

          it 'argument 2 of 2 cannot be nil' do
            @field_name = 'bananas'
            @parent_hash = nil
            assert_argument_error 'parent_hash'
          end
        end

        context 'but the underlying hash does not have the correct fields' do
          before :each do
            @hash = { 'oranges' => 'uh ohes' }
          end

          it '#new raises no error upon initialization' do
            ValidDummyRawResponse.new(@hash)
          end
        end

      end

      context 'when the inheriting class does not override the required methods' do
        class FailDummyRawResponse < Cb::Responses::ApiResponse; end

        def assert_not_implemented_method_name(method_name, &expected_to_raise_error)
          begin
            expected_to_raise_error.call
            raise 'this test should not have made it this far!' # fail if proc code does not raise error
          rescue NotImplementedError => ex
            ex.message.include?(method_name).should eq true
          end
        end

        it 'raises an exception on initialize' do
          assert_not_implemented_method_name('root_node') { FailDummyRawResponse.new(Hash.new) }
        end

        it 'raises an exception when attempting to extract models' do
          assert_not_implemented_method_name('root_node') do
            class FailDummyRawResponse; def validate_raw_api_response; end end # avoiding the initialize exception
            FailDummyRawResponse.new(Hash.new).models
          end
        end
      end

      context 'when directly instantiating the base class' do
        it 'raises NotImplementedError upon initialization' do
          expect { Responses::ApiResponse.new }.to raise_error NotImplementedError
        end
      end

    end # new

  end
end
