require_relative '../m3ufile'
require_relative './spec_helper'

describe 'M3uFile tests' do
  it 'finds a valid filename to write to in the default case ' do
    m = M3uFile.new
    m.getfilename
    expect(m.getfilename.size).to be > 1
  end

  it 'gets configured by a user preference' do
    m = M3uFile.new
    test_yaml_object = { 'filename' => '~/Music/oop.m3u' }
    m.config = test_yaml_object
    expect(m.getfilename).to end_with('oop.m3u')
  end

  it 'makes an m3u file in the default case' do
    s = SomafmPlaylist.new
    s.make_m3u_file
    mf = M3uFile.new.getfilename
    expect(File).to exist(File.expand_path(mf))
  end

  it 'defaults to a standard default in case of junk config' do
    m = M3uFile.new
    test_yaml_object = { 'foo' => 'bar' }
    m.config = test_yaml_object
    expect(m.getfilename).to eq '~/Music/somafm.m3u'
  end
end
