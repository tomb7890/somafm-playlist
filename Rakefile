# rubocop:disable HashSyntax

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

require_relative 'somafm'

RuboCop::RakeTask.new

task :default => [:spec, :rubocop]

if 'test' == ENV['ENV']
  desc 'Run the specs.'
  RSpec::Core::RakeTask.new do |t|
    t.pattern = '*_spec.rb'
  end
else
  s = SomafmPlaylist.new
  s.make_m3u_file
end
