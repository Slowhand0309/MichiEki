# encoding: utf-8
require 'json'
require_relative '../lib/michieki'

module MichiEki
  class Search < Grape::API
    format :json

    params do
      requires :lat, type: String, desc: "latitude"
      requires :lon, type: String, desc: "longitude"
    end

    # Search road station
    get '/search' do
      # TODO
    end
  end
end
