# rubocop:disable HashSyntax
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
RuboCop::RakeTask.new

task :default => [:spec, :rubocop]

desc 'Run the specs.'
RSpec::Core::RakeTask.new do |t|
  t.pattern = '*_spec.rb'
end
