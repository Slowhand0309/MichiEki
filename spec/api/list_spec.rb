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

  it 'list query area' do
    json = open(URI.escape("http://michieki.example.com/api/list?area=東京都")).read
    result = JSON.parse(json)
    expect(result['area']).to eq '東京都'
  end

  it 'list query name' do
    json = open(URI.escape("http://michieki.example.com/api/list?name=なち")).read
    result = JSON.parse(json)
    expect(result['area']).to eq '和歌山県'
    expect(result['name']).to eq 'なち'
  end

  it 'list query area + name' do
    json = open(URI.escape("http://michieki.example.com/api/list?area=大阪&name=かなん")).read
    result = JSON.parse(json)
    expect(result['area']).to eq '大阪府'
    expect(result['name']).to eq 'かなん'
  end
end
