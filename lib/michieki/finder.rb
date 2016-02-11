# encoding: utf-8

module MichiEki
  class Finder
    # road station infomation data
    LIST_JSON_FILE = 'data/station_list.json'.freeze

    # locations data
    LOCATION_JSON_FILE = 'data/locations.json'.freeze

    # not found area
    UNKOWN_AREA = 'unkown'.freeze

    # threshold for find area
    THRESHOLD = 0.05

    def find(params)
      lat = params[:lat]
      lng = params[:lng]

      areas = []
      if lat != nil && lng != nil
        areas = find_areas(lat, lng)
      end
      get_stations(areas, lat, lng)
    end

    def find_areas(lat, lng)
      areas = []
      locations = JSON.load(open(LOCATION_JSON_FILE, 'r:utf-8').read)
      locations.each do |k, v|
        _lat = v['lat']
        _lng = v['lng']
        if (_lat - lat).abs < THRESHOLD && (_lng - lng).abs < THRESHOLD
          puts "area : #{k}, lat : #{_lat}, lng : #{_lng}" # TODO for debug
          areas << k
        end
      end
      areas
    end

    def get_stations(areas, lat, lng)
      stations = []
      station_list = JSON.load(open(LIST_JSON_FILE, 'r:utf-8').read)
      areas.each do |area|
        stations << station_list[area] if station_list.include? area
      end
      stations
    end
  end
end
