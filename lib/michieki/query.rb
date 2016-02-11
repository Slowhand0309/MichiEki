# encoding: utf-8
require 'json'

module MichiEki
  class Query

    # road station infomation data
    LIST_JSON_FILE = 'data/station_list.json'.freeze

    def initialize
      load
    end

    # query the road station data
    def query(params)

      # where area
      query_data = nil
      if params[:area] != nil
        if @data.include?(params[:area])
          query_data = @data[params[:area]]
          query_data[:area] = params[:area]
        end
      end

      # where name
      if params[:name] != nil
        if query_data != nil
          # query area & name
          query_data = search_name(query_data, params)
        else
          # query name
          @data.each do |k,v|
            query_name = search_name(v, params)
            if query_name != nil
              query_data = query_name
              query_data[:area] = k
              break
            end
          end
        end
      end

      if params[:area] != nil || params[:name] != nil
        query_data
      else
        @data
      end
    end

    # search equal name
    def search_name(query_data, params)

      query_name = nil
      query_data.each do |k, v|
        if v.kind_of?(Hash)
          if v['name'].include?(params[:name])
            query_name = v
            break
          end
        end
      end
      return query_name
    end

    def load
      @data = JSON.load(open(LIST_JSON_FILE, 'r:utf-8').read)
    end

  end
end
