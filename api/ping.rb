module MichiEki
  class Ping < Grape::API
    format :json
    get '/ping' do
      { ping: 'pong' }
    end
  end
end
