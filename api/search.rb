# encoding: utf-8
require 'json'
require_relative '../lib/michieki'

module MichiEki
  class Search < Grape::API
    format :json

    params do
      requires :lat, type: Float, desc: "latitude"
      requires :lng, type: Float, desc: "longitude"
      optional :scope, type: Integer, desc: "Area search scope"
    end

    # Search road station
    get '/search' do
      MichiEki::Finder.new.find(params)
    end
  end
end
