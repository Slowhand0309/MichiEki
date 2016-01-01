require 'sham_rack'
require_relative '../app/api'

#$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end

ShamRack.at('michieki.example.com').rackup do
  run MichiEki::API
end
