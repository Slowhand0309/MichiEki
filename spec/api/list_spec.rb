# encoding: utf-8

require "michieki"
require "spec_helper"
require 'open-uri'
require 'json'

RSpec.describe MichiEki::List do

  before do
    # check exist data file
    unless FileTest.exist?('data/station_list.json')
      fail('please generate data file by [rake all]')
    end
  end

  it 'list' do
    json = open(URI.escape("http://michieki.example.com/api/list?area=東京都")).read
    result = JSON.parse(json)
    expect(result['area']).to eq '東京都'
  end
end
