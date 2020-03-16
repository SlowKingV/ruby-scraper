require_relative 'connection_handler.rb'
require_relative 'file_handler.rb'

class Scraper
  require 'nokogiri'
  attr_reader :doc, :repo_dataset

  def initialize(ref)
    @ref = ref
    @doc = parse_file
  end

  def compare(data)
    @repo_dataset == data
  end

  private

  def parse_file; end
end

class ScrapHTML < Scraper
  def initialize(ref, num = 50)
    super(ref)
    @nodes = fetch_nodes(num)
    parse_nodes
  end

  private

  def parse_file
    Nokogiri::HTML(@ref)
  end

  def fetch_nodes(num)
    @nodes = @doc.css('ul.repo-list > li.repo-item')[0..(num - 1)]
  end

  def parse_nodes
    @repo_dataset = []
    @nodes.each { |node| @repo_dataset << to_data(node) }
  end

  def to_data(node)
    data = {}
    data[:name] = node.at('.repo-item-title').content
    data[:issues] = node.at('.repo-item-issues').content.match(/\d+/)[0]
    data[:prior] = node['class'].split[1]
    data[:desc] = node.at('.repo-item-description').content
    data[:path] = node.at('.repo-item-full-name').content[1..-2]
    data[:url] = 'https://github.com/' + data[:path]
    data
  end
end

class ScrapXML < Scraper
  def initialize(ref)
    super(ref)
    refresh unless @doc.content.empty?
  end

  class << self
    def to_str(data)
      high = []
      medium = []
      low = []
      data.each do |elem|
        case elem[:prior]
        when 'high'
          high << to_node(elem)
        when 'medium'
          medium << to_node(elem)
        when 'low'
          low << to_node(elem)
        end
      end
      "<high>#{high.join}\n</high>\n<medium>#{medium.join}\n</medium>\n<low>#{low.join}\n</low>"
    end

    private

    def to_node(data)
      "
  <item name='#{data[:name]}' issues='#{data[:issues]}'>
    <description>#{data[:desc]}</description>
    <path>#{data[:path]}</path>
    <url>#{data[:url]}</url>
  </item>"
    end
  end

  private

  def refresh
    @nodes = fetch_nodes
    parse_nodes unless @nodes.empty?
  end

  def parse_file
    Nokogiri::XML(@ref)
  end

  def fetch_nodes
    @nodes = @doc.css('item')
  end

  def parse_nodes
    @repo_dataset = []
    @nodes.each { |node| @repo_dataset << to_data(node) }
  end

  def to_data(node)
    data = {}
    data[:name] = node['name']
    data[:issues] = node['issues']
    data[:prior] = node.parent.name
    data[:desc] = node.at('description').content
    data[:path] = node.at('path').content
    data[:url] = 'https://github.com/' + data[:path]
    data
  end
end