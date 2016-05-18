# rubocop:disable HashSyntax

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

require_relative 'somafm'

RuboCop::RakeTask.new

task :default => [:spec ]#, :rubocop]

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
  task :test => :spec
end

task :go do
  s = SomafmPlaylist.new
  s.make_m3u_file
end
