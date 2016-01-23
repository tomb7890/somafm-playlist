# !/usr/bin/ruby -w

require 'net/http'
require 'nokogiri'

# The SomafmPlaylist class is used to extract Soma FM streaming links
# to a local M3u file for the conveninent playing with a standalone player
class SomafmPlaylist
  def channels
    ndoc = Nokogiri::HTML(remote_html)
    ndoc.xpath('//ul/li/a/@href').to_s.split('//')
  end

  def groove_salad_uri
    'http://uwstream1.somafm.com:80'
  end

  private

  def local_html
    File.open('somafm.html', 'rb').read
  end

  def remote_html
    uri = URI.parse('http://somafm.com')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.body
  end
end
