require 'yaml'

# This class encapsulates the knowledge about M3uFile creation. By
# default it looks to a standard place for a config.yml file, from which
# it gleans a location for the writing of a M3U file.
class M3uFile
  attr_accessor :config

  def openfile
    File.open(getfilename, 'w')
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
    @config = getconfig if @config.nil?
    File.expand_path(@config['filename'])
  end

  def getconfig
    configfile = 'config/config.yml'
    YAML.load_file(configfile)
  end
end
