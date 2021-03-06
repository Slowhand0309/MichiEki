# encoding: utf-8
require 'open-uri'
require 'nokogiri'
require 'kconv'
require 'json'

module MichiEki

  # generate road station list class
  # from http://www.seaview.jp/rs/index.html
  class StationListGenerator

     ATTR_LIST = ["name", "lat", "lng", "park", "", "", "", "address"].freeze
     IGNORE_INDEX = [4, 5, 6].freeze

    # initialize
    def initialize()
      @data = {}
    end

    # setting url
    def set_url(url)
      @url = url
    end

    def run
      html = open(@url).read
      doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')

      area = nil
      area_name = ""
      station = {}

      index = 0
      doc.xpath('//table//td').each do |node|
        str = node.text
        next if str.length > 100
        if str.include?("▼")
          @data[area_name] = area if area
          area = {}
          area_name = str.delete("▼")
          index = 0
          next
        end
        if area && station
          if IGNORE_INDEX.include?(index)
            index = index + 1
            next
          end

          station[ATTR_LIST[index]] = str
          index = index + 1
          if index >= ATTR_LIST.size
            area[station["name"]] = station
            station = Hash.new
            index = 0
          end
        end
      end
      @data[area_name] = area if area
    end

    # write file to json format
    def write_json(file)
      open(file, "w") do |io|
      	io.write(JSON.pretty_generate(@data))
      end
    end
  end
end
