require_relative '../somafm'
require_relative './spec_helper'

def parsefile(p, filename)
  page = File.open(filename, 'rb').read
  p.parse(page)
end

describe 'local tests' do
  it 'detects a bad URI' do
    baduri = '##$$%%'
    expect { URI.parse(baduri) }.to raise_error(URI::InvalidURIError)
  end

  it 'finds groovesalad in results set ' do
    s = SomafmPlaylist.new
    expect(s.channels).to include('groovesalad')
  end

  it 'finds secretagent in results set ' do
    s = SomafmPlaylist.new
    expect(s.channels).to include('secretagent')
  end

  it 'finds seven groovesalad formats' do
    p = M3U::Parser.new
    parsefile(p, 'spec/data/somafm.com/groovesalad/directstreamlinks.html')
    expect(p.formats.size).to eq 7
  end

  it 'finds six suburbsofgoa Formats' do
    s = SomafmPlaylist.new
    channels = s.channels
    ch = channels.find { |c| c.include?('goa') }
    formats = s.format_list_from_channel_name(ch)
    expect(formats.size).to eq 6
  end
end
