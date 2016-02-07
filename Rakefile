# coding: utf-8
require 'yaml'
require 'json'
require 'fileutils'
require_relative 'lib/michieki'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :all

# task for generate road station info list
task :genlist do
  puts "=========> start genlist task..."
  conf = YAML.load_file('config/config.yml')
  url_list = conf["gen_urls"]

  gen = MichiEki::StationListGenerator.new

  url_list.each do |url|
    puts "get data from >> #{url}"
    gen.set_url(url)
    gen.generate
  end
  gen.write_json("data/station_list.json")
  puts "=========> success generate road station list"
end

# task for generate info
task :geninfo do
  puts "=========> start geninfo task..."
  conf = YAML.load_file('config/config.yml')
  info = conf["info"]

  open("data/info.json", "w") do |io|
    io.write(JSON.pretty_generate(info))
  end
  puts "=========> success generate info.json"
end

task :genlocations do
  puts "=========> start genlocations task..."
  generator = MichiEki::LocationsGenerator.new
  generator.run
  puts "=========> success generate locations.json"
end

# task for remove data files
task :clean do
  puts "=========> remove data files..."
  FileUtils.rm(Dir.glob('data/*.json'))
  puts "=========> success remove data file"
end

# task for all.
task all: [:clean, :geninfo, :genlist, :spec] do
  puts "all generate files."
end
