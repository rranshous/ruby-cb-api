require 'spec_helper'

module Cb
  describe Responses::State do
    let(:response) { Cb::RSpec::Data.for described_class }
    let(:states) { Cb::Responses::State.new(response) }

    context 'when everything works as expected' do
      it { expect(states.models[1].key).to eq('AL') }
    end
  end
end
