# encoding: utf-8
require 'json'
require_relative '../lib/michieki'

module MichiEki
  class List < Grape::API
    format :json

    def initialize
      @query = MichiEki::Query.new
    end

    params do
      optional :area, type: String, desc: "Target area"
    end
    # GET road station list
    get '/list' do
      @query.query(params)
    end
  end
end
