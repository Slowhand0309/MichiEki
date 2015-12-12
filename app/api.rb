# encoding: utf-8
require 'grape'
require_relative '../api/ping'
require_relative '../api/info'
require_relative '../api/list'

module MichiEki
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::MichiEki::Ping
    mount ::MichiEki::Info
    mount ::MichiEki::List
  end
end
