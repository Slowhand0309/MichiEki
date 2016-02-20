# encoding: utf-8

require "michieki"
require "spec_helper"
require 'open-uri'
require 'json'

RSpec.describe MichiEki::Search do

  before do
    # check exist data file
    unless FileTest.exist?('data/station_list.json')
      fail('please generate data file by [rake all]')
    end
  end

  it 'search area' do
    json = open(URI.escape("http://michieki.example.com/api/search?lat=35.41&lng=139.20&scope=10")).read
    result = JSON.parse(json)
    expect(result.size).to eq 1
    expect(result[0]['name']).to eq '八王子滝山'
  end

end
