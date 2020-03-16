#!/usr/bin/env ruby

require 'json'
require './lib/connection_handler.rb'
require './lib/file_handler.rb'
require './lib/scraper.rb'

ScrapHTML.refresh_tags(Connection.new.file)
config = JSON.parse(File.read('repo/config.json'))
filename = config['selected']
local = []
remote = []
local[0] = FileHandler.new(filename)
local[1] = ScrapXML.new(local[0].file)
remote[0] = Connection.new(local[1].tag)
remote[1] = ScrapHTML.new(remote[0].file)
input = -1

until input.zero?
  filename = config['selected']
  print "
  | Open Source Contributions
    - Active File: #{filename}


  |1> Update Selected File
  |2> Inspect Selected File
  |3> Select a Different File
  |4> Create a New File

  |0> Exit

  Select an option: "
  input = gets.strip.to_i

  case input
  when 1
    puts 'Fetching data...'
    remote[0] = Connection.new(local[1].tag)
    remote[1] = ScrapHTML.new(remote[0].file)
    if !remote[1].compare(local[1].dataset)
      puts 'Changes found! Updating File...'
      local[0].file.rewind
      local[0].file.puts("<repo tag='#{local[1].tag}'>\n#{ScrapXML.to_str(remote[1].dataset)}\n</repo>")
      puts 'File Changed! (Press [Enter] to continue)'
    else
      puts 'File is already up-to-date (Press [Enter] to continue)'
    end
    gets
  when 2
    puts "Reading <#{filename}>..."
    puts "\n#{local[0].read}"
    puts "\n(Press [Enter] to continue)"
    gets
  when 3
    files = FileHandler.list_files
    files.each_with_index { |f, i| puts "#{i} = #{f}" }
    print 'Select one of the previous files: '
    opt = gets.strip.to_i
    puts 'Refreshing local data...'
    local[0] = FileHandler.new(files[opt].gsub(/\.\w+/, ''))
    local[1] = ScrapXML.new(local[0].file)
    puts 'Updating remote data...'
    remote[0] = Connection.new(local[1].tag)
    remote[1] = ScrapHTML.new(remote[0].file)
    puts 'Updating config file...'
    config['selected'] = files[opt].gsub(/\.\w+/, '')
    json = JSON.generate(config)
    File.open('repo/config.json', 'w') do |file|
      file.rewind
      file.puts(json)
    end
    puts 'New file selected!(Press [Enter] to continue)'
    getsfiles
  when 4
    print 'Enter the new file name: '
    name = gets.strip
    tags = ScrapHTML.tags
    tags[0] = 'All'
    tags.each_with_index { |f, i| puts "#{i} = #{f}" }
    tags[0] = ''
    print 'Enter the language to listen: '
    tag = gets.strip.to_i
    puts 'Fetching remote data...'
    remote[0] = Connection.new(tags[tag])
    remote[1] = ScrapHTML.new(remote[0].file)
    puts 'Creating local file...'
    local[0] = FileHandler.new(name)
    local[1] = ScrapXML.new(local[0].file)
    local[0].file.rewind
    local[0].file.puts("<repo tag='#{remote[1].tag}'>\n#{ScrapXML.to_str(remote[1].dataset)}\n</repo>")
    puts 'File generated...(Press [Enter] to continue)'
    gets
  when 0
    puts 'Terminating the program...'
  else
    puts 'Enter a valid option'
    puts 'Returning to Main Screen...'
  end
end
