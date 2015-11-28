# encoding: utf-8
require 'open-uri'
require 'nokogiri'
require 'kconv'
require 'json'

module MichiEki


  class StationListGenerator

     ATTR_LIST = ["name", "lat", "lng", "park", "", "", "", "address"]
     IGNORE_INDEX = [4, 5, 6]

    # initialize
    def initialize()
      @data = Array.new
    end

    # setting url
    def set_url(url)
      @url = url
    end

    def generate
      html = open(@url).read
      doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')

      area = nil
      station = {}

      index = 0
      doc.xpath('//table//td').each do |node|
        str = node.text
        next if str.length > 100
        if str.include?("▼")
          @data << area if area != nil
          area = {}
          area["area"] = str
          index = 0
          next
        end
        if area != nil && station != nil
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

      @data << area if area != nil
    end

    # write file to json format
    def write_json(file)
      open(file, "w") do |io|
      	io.write(JSON.pretty_generate(@data))
      end
    end
  end
end
