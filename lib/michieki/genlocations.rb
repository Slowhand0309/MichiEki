# encoding: utf-8
require 'json'
require 'geocoder'

module MichiEki
  class LocationsGenerator

    CONFIG_YML = 'config/config.yml'.freeze
    ADDRESS_LIST_KEY = 'geo_address'.freeze
    LAT = 'lat'.freeze
    LNG = 'lng'.freeze

    def initialize
      Geocoder.configure(:language  => :ja, :units => :km)
    end

    def run
      conf = YAML.load_file(CONFIG_YML)
      unless conf
        raise StandardError, "Not found config file."
      end

      address_maps = conf[ADDRESS_LIST_KEY]
      unless address_maps
        raise StandardError, "Not found #{ADDRESS_LIST_KEY} key in config file."
      end

      @geo_map = {}
      address_maps.each do |k, v|
        info = Geocoder.search(v)[0]
        puts "k:#{k}, v:#{v}"
        next if info == nil

        location = info.geometry["location"]
        # TODO debug
        puts "lat : #{location[LAT]}"
        puts "lng : #{location[LNG]}"
        @geo_map[k] = {LAT => location[LAT], LNG => location[LNG]}
        sleep 1 # avoid 'Google Geocoding API error: over query limit.''
      end
    end

    # write file to json format
    def write_json(file)
      open(file, "w") do |io|
      	io.write(JSON.pretty_generate(@geo_map))
      end
    end
  end
end
