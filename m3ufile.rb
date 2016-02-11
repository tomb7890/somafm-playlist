require 'yaml'

# This class encapsulates the knowledge about M3uFile creation. By
# default it looks to a standard place for a config.yml file, from
# which it gleans a location for the writing of a M3U file. If
# something wrong with config file it will default to DEFAULT_FILE
class M3uFile
  attr_accessor :config
  DEFAULT_FILENAME = '~/Music/somafm.m3u'.freeze

  def openfile
    File.open(File.expand_path(getfilename), 'w')
  end

  def write_entry(trackname, url)
    @f = openfile if @f.nil?
    @f.write("#EXTINF:-1,#{trackname}\n\n")
    @f.write("#{url}\n\n")
  end

  def close
    @f.close
  end

  def exists?
    File.exist?(getfilename)
  end

  def getfilename
    rc = DEFAULT_FILENAME
    @config = getconfig if @config.nil?
    unless @config
      t = @config['filename']
      rc = t unless t
    end
    rc
  end

  def getconfig
    configfile = 'config/config.yml'
    YAML.load_file(configfile)
  end
end
