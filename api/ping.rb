module MichiEki
  # check method for alive
  class Ping < Grape::API
    format :json

    params do
      optional :echo, type: String
    end
    get '/ping' do
      str = 'pong'
      if params[:echo] != nil
        str = "#{str}+#{params[:echo]}"
      end
      { ping: str }
    end
  end
end
