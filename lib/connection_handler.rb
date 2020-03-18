class Connection
  require 'erb'
  require 'open-uri'
  attr_reader :file

  def initialize(lang = '')
    @file = connect(lang)
  end

  private

  def connect(lang)
    lang = ERB::Util.url_encode(lang)
    url = 'https://www.codetriage.com'
    url << "/?language=#{lang}" unless lang.empty?
    URI.open(url)
  end
end
