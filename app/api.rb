require 'grape'
require_relative '../api/ping'

module MichiEki
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::MichiEki::Ping
  end
end
