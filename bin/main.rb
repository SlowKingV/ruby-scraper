#!/usr/bin/env ruby

require 'json'
require 'nokogiri'

print '
| Open Source Contributions
  - Active File: entry_test


|1> Update Selected File
|2> Inspect Selected File
|3> Select a Different File
|4> Create a New File

|0> Exit

Select an option: '
input = gets.strip.to_i

case input
when 1
  puts 'Fetching data...'
  puts 'File updated, do you want to inspect it now?(Y/N)'
  gets.strip
when 2
  puts 'Reading <entry_test.xml>...'
  puts '[Data]'
  gets.strip
when 3
  puts '[Listed Files]'
  print 'Select one of the previous files: '
  gets.strip
when 4
  puts 'Enter the new file name: '
  gets.strip
  puts 'Enter one Tag to listen: '
  gets.strip
  puts 'Fetching data...'
  puts 'File Generated. Select and view it now?(Y/N)'
  gets.strip
when 0
  puts 'Terminating the program...'
else
  puts 'Enter a valid option'
  puts 'Returning to Main Screen...'
end
