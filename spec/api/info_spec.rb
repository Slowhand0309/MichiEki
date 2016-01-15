# encoding: utf-8

require "michieki"
require "spec_helper"
require 'open-uri'
require 'json'
require 'fileutils'

RSpec.describe MichiEki::Info do

  before do
    # check exist data file
    unless FileTest.exist?('data/info.json')
      fail('please generate data file by [rake all]')
    end

    conf = YAML.load_file('config/config.yml')
    @info = conf["info"]
  end

  it 'get info' do
    json = open("http://michieki.example.com/api/info").read
    result = JSON.parse(json)
    expect(result['version']).to eq @info['version']
    expect(result['methods']).to eq @info['methods']
    expect(result['link']).to eq @info['link']
  end
end
