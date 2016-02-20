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
      if params[:area]
        area = scan(params[:area])
        if area
          query_data = @data[area]
          query_data[:area] = area
        end
      end

      # where name
      if params[:name]
        if query_data
          # query area & name
          result = search_data(query_data, params[:name])
          result[:area] = query_data[:area]
          query_data = result
        else
          # query name
          @data.each do |k,v|
            query_data = search_data(v, params[:name])
            if query_data
              query_data[:area] = k
              break
            end
          end
        end
      end

      if params[:area] || params[:name]
        query_data
      else
        @data
      end
    end

    def scan(area)
      @areas.find {|v| v.include?(area)}
    end

    # search equal name
    def search_data(query_data, name)

      data = nil
      query_data.each do |k, v|
        if v['name'].include?(name)
          data = v
          break
        end
      end
      return data
    end

    def load
      @data = JSON.load(open(LIST_JSON_FILE, 'r:utf-8').read)
      @areas = Set.new(@data.keys)
    end

  end
end
