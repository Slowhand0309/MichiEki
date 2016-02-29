# coding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'sham_rack'
require 'app/api'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end

ShamRack.at('michieki.example.com').rackup do
  run MichiEki::API
end
