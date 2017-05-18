require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'
require 'circleci/coverage_reporter/rake_task'
require 'rubycritic/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.verbose = false
end

RuboCop::RakeTask.new

YARD::Rake::YardocTask.new

CircleCI::CoverageReporter.configure do |config|
  config.reporters << CircleCI::CoverageReporter::Link::Reporter.new('doc', 'index.html', name: 'YARD')
end

desc 'Run RubyCritic'
task :rubycritic do
  base_options = "-p #{ENV['CIRCLE_ARTIFACTS'] || '.'}/rubycritic --mode-ci --no-browser"
  sh "bundle exec rubycritic #{base_options} -f html lib"
  sh "bundle exec rubycritic #{base_options} -f json lib" if ENV['CIRCLECI']
end

task default: %i[spec rubocop]
