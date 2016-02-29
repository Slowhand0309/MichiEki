# encoding: utf-8
require 'json'
require 'lib/michieki'

module MichiEki
  class List < Grape::API
    format :json

    params do
      optional :area, type: String, desc: "Target area"
    end
    # GET road station list
    get '/list' do
      MichiEki::Query.new.query(params)
    end
  end
end
