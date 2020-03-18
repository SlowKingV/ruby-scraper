class Scraper
  require 'nokogiri'
  attr_reader :doc, :dataset, :tag

  def initialize(ref)
    @ref = ref
    @doc = parse_file
  end

  def compare(data)
    @dataset == data
  end

  private

  def parse_file; end
end

class ScrapHTML < Scraper
  @tags = ['']

  def initialize(ref, num = 50)
    super(ref)
    fetch_nodes(num)
    parse_nodes
  end

  class << self
    attr_reader :tags

    def refresh_tags(src)
      doc = Nokogiri::HTML(src)
      doc.css('ul.types-filter > li > a').each { |node| @tags << node['data-language'] }
    end
  end

  private

  def parse_file
    Nokogiri::HTML(@ref)
  end

  def fetch_nodes(num)
    @nodes = @doc.css('ul.repo-list > li.repo-item')[0..(num - 1)]
    @tag = @doc.at_css('a.types-filter-button').content
  end

  def parse_nodes
    @dataset = []
    @nodes.each { |node| @dataset << to_data(node) }
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
    @tag = ''
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
    fetch_nodes
    parse_nodes unless @nodes.empty?
  end

  def parse_file
    Nokogiri::XML(@ref)
  end

  def fetch_nodes
    @nodes = @doc.css('item')
    @tag = @doc.at_css('repo')['tag']
  end

  def parse_nodes
    @dataset = []
    @nodes.each { |node| @dataset << to_data(node) }
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
