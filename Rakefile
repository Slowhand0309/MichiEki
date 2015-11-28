# coding: utf-8
require 'yaml'
require_relative 'lib/michieki'

# task for generate road station info list
task :genlist do
  puts "=========> start genlist task..."
  conf = YAML.load_file('config/config.yml')
  url_list = conf["gen_urls"]

  gen = MichiEki::StationListGenerator.new

  url_list.each do |url|
    puts "get data from >> " + url
    gen.set_url(url)
    gen.generate
  end
  gen.write_json("data/station_list.json")
  puts "=========> success generate road station list"
end
