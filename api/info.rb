# encoding: utf-8
require 'json'
require_relative '../lib/michieki'

module MichiEki
  class Info < Grape::API
    format :json

    # infomation data file
    INFO_JSON_FILE = 'data/info.json'.freeze

    # GET road infomation
    get '/info' do
      JSON.load(open(INFO_JSON_FILE, 'r:utf-8').read)
    end
  end
end
