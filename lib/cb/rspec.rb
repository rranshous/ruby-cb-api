require 'cb/rspec/mocks'

RSpec.configure do |config|
  config.include Cb::RSpec::Mocks

  config.before(:each) { stub_cb_api }
  config.after(:each) { cb_responses_stub_map.clear }
end
