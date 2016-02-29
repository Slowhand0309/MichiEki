# encoding: utf-8
require 'grape'
require 'api/ping'
require 'api/info'
require 'api/list'
require 'api/search'

module MichiEki
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::MichiEki::Ping
    mount ::MichiEki::Info
    mount ::MichiEki::List
    mount ::MichiEki::Search
  end
end
