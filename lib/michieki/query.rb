# encoding: utf-8
require 'json'

module MichiEki
  class Query

    # road station infomation data
    LIST_JSON_FILE = 'data/station_list.json'

    def initialize
      @data = JSON.load(open(LIST_JSON_FILE, 'r:utf-8').read)
    end

    # query the road station data
    def query(params)

      # where area
      query_data = nil
      if params[:area] != nil
        puts params[:area]
        @data.each do |area_data|
          if area_data['area'].include?(params[:area])
            query_data = area_data
            break
          end
        end
      end

      # where name
      if params[:name] != nil
        query_name = nil
        if query_data != nil
           query_data.each do |k, v|
             if v.kind_of?(Hash)
               if v['name'].include?(params[:name])
                 query_name = v
                 break
               end
             end
           end
           query_data = query_name if query_name != nil
        end
      end

      if query_data != nil
        query_data
      else
        @data
      end
    end
  end
end
