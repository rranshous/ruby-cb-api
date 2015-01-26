require 'spec_helper'

module Cb
  describe RSpec do
    before do
      allow_any_instance_of(::RSpec::Core::Configuration).to receive(:include)
      allow_any_instance_of(::RSpec::Core::Configuration).to receive(:before)
      allow_any_instance_of(::RSpec::Core::Configuration).to receive(:after)
      allow_any_instance_of(Object).to receive(:stub_cb_api)
      allow_any_instance_of(Object).to receive(:cb_responses_stub_map).and_return(cb_responses_stub_map)
    end

    let(:cb_responses_stub_map) do
      { i: 'stub data for responses' }
    end

    context 'When cb/rspec.rb is required' do
      it { expect_any_instance_of(::RSpec::Core::Configuration).to receive(:before).with(:each) }
      it { expect_any_instance_of(::RSpec::Core::Configuration).to receive(:after).with(:each) }
      it { expect_any_instance_of(::RSpec::Core::Configuration).to receive(:include).with(Cb::RSpec::Mocks) }
      it { expect_any_instance_of(Object).not_to receive(:stub_cb_api) }
      it { expect(cb_responses_stub_map).not_to receive(:clear) }

      context 'When we yield the before block' do
        before { allow_any_instance_of(::RSpec::Core::Configuration).to receive(:before).and_yield }

        it { expect_any_instance_of(Object).to receive(:stub_cb_api) }
      end

      context 'When we yield the after block' do
        before { allow_any_instance_of(::RSpec::Core::Configuration).to receive(:after).and_yield }

        it { expect(cb_responses_stub_map).to receive(:clear) }
      end

      after { load 'cb/rspec.rb' }
    end
  end
end
