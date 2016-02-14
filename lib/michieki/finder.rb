# encoding: utf-8
require 'geocoder'

module MichiEki
  class Finder
    # road station infomation data
    LIST_JSON_FILE = 'data/station_list.json'.freeze

    # locations data
    LOCATION_JSON_FILE = 'data/locations.json'.freeze

    # not found area
    UNKOWN_AREA = 'unkown'.freeze

    # threshold for find area
    THRESHOLD = 0.1

    # default scope area (km)
    SCOPE_AREA = 100

    # configuration to japan locate
    Geocoder.configure(:language  => :ja, :units => :km)

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
#          puts "area : #{k}, lat : #{_lat}, lng : #{_lng}" # TODO for debug
          areas << k
        end
      end
      areas
    end

    def get_stations(areas, lat, lng)
      stations = []
      if areas.size.zero?
        return stations
      end

      # to array
      from = [lat.to_f, lng.to_f]

      station_list = JSON.load(open(LIST_JSON_FILE, 'r:utf-8').read)
      areas.each do |area|
        list = station_list[area]
        if list
          list.each do |k, v|
            # to array
            _lat  = format(v['lat'])
            _lng  = format(v['lng'])
            to = [_lat.to_f, _lng.to_f]
            distance = Geocoder::Calculations.distance_between(from, to)
            stations << v if distance < SCOPE_AREA
          end
        end
      end
      stations
    end

    def format(position)
      values = position.split('.')
      "#{values[0]}.#{values[1]}#{values[2]}"
    end
  end
end
