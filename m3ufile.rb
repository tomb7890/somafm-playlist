class M3uFile
  def initialize
  end

  def open
    @f = File.open(filename, 'w')
  end

  def write_entry(trackname, url)
    @f.write("#EXTINF:-1,#{trackname}\n\n")
    @f.write("#{url}\n\n")
  end

  def close
    @f.close
  end

  def exists?
    File.exist?(filename)
  end

  def filename
    configfile = 'config/config.yml'
    if File.exist?(configfile)
      config = YAML.load_file(configfile)
      m3ufile = File.expand_path(config['filename'])
    else
      m3ufile = File.expand_path('~/Music/somafm.m3u')
    end
  end
end
