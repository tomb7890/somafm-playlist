# !/usr/bin/ruby -w

require_relative 'parser'
require_relative 'm3ufile'
require 'net/http'
require 'nokogiri'

# The SomafmPlaylist class is used to extract links from a streaming
# radio site and write them to a local M3U file for playback
# using an alternative player.
class SomafmPlaylist
  def channels
    # returns a list of text strings representing the channel names
    ndoc = Nokogiri::HTML(remote_html)
    elements = ndoc.xpath('//ul/li/a/@href').to_s.split('//')
    elements.map! do |e|
      e.tr('//', '')
    end
  end

  def make_m3u_file
    m3u = M3uFile.new
    return if m3u.exists?
    m3u.openfile
    channels.each do |ch|
      make_m3u_entry_from_channel(ch, m3u)
    end
    m3u.close
  end

  def format_list_from_channel_name(channel)
    # Given a channel name, retrieve a list of formats
    dslpage = "http://somafm.com/#{channel}/directstreamlinks.html"
    response_body = remote_html(dslpage)
    process_response(response_body)
  end

  private

  def make_m3u_entry_from_channel(ch, m3u)
    formats = format_list_from_channel_name(ch)
    mp3fmt = formats.find { |format| format.title.include?('MP3 128') }
    if mp3fmt
      server = mp3fmt.servers.find { |s| s.include?('Direct') }
      trackname = "#{ch} #{server}"
      url = server.split(': ')[1]
      m3u.write_entry(trackname, url)
    end
  end

  def process_response(r)
    p = M3U::Parser.new
    p.parse(r)
    p.formats
  end

  def local_html
    File.open('somafm.html', 'rb').read
  end

  def remote_html(u = 'http://somafm.com')
    uri = URI.parse(u)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.body
  end
end
