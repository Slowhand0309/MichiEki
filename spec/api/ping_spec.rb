# encoding: utf-8

require "michieki"
require "spec_helper"
require 'open-uri'
require 'json'
require 'fileutils'

RSpec.describe MichiEki::Ping do

  it 'ping' do
    json = open("http://michieki.example.com/api/ping").read
    result = JSON.parse(json)
    expect(result['ping']).to eq 'pong'
  end

  it 'echo' do
    json = open("http://michieki.example.com/api/ping?echo=hello").read
    result = JSON.parse(json)
    expect(result['ping']).to eq 'pong+hello'
  end
end
