# encoding: utf-8
require 'json'
require 'geocoder'

module MichiEki
  class LocationsGenerator

    CONFIG_YML = 'config/config.yml'.freeze
    ADDRESS_LIST_KEY = 'geo_address'.freeze

    def initialize
      Geocoder.configure(:language  => :ja, :units => :km)
    end

    def run
      conf = YAML.load_file(CONFIG_YML)
      unless conf
        raise StandardError, "Not found config file."
      end

      adr_list = conf[ADDRESS_LIST_KEY]
      unless adr_list
        raise StandardError, "Not found #{ADDRESS_LIST_KEY} key in config file."
      end

      adr_list.each do |adr|
        location = Geocoder.search(adr)[0].geometry["location"]
        # TODO debug
        puts "lat : #{location['lat']}"
        puts "lng : #{location['lng']}"
      end

    end
  end
end
