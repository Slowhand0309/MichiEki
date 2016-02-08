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

      geo_map = {}
      address_maps.each do |k, v|
        location = Geocoder.search(v)[0].geometry["location"]
        # TODO debug
        puts "lat : #{location[LAT]}"
        puts "lng : #{location[LNG]}"
        geo_map[k] = {LAT => location[LAT], LNG => location[LNG]}
      end
      p geo_map
    end
  end
end
