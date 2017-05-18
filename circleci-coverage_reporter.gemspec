# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'circleci/coverage_reporter/version'

Gem::Specification.new do |spec|
  spec.name          = 'circleci-coverage_reporter'
  spec.version       = CircleCI::CoverageReporter::Version.to_s
  spec.authors       = ['Yuku Takahashi']
  spec.email         = ['yuku@qiita.com']

  spec.summary       = 'Report test coverage to your GitHub repository'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/increments/circleci-coverage_reporter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_development_dependency 'bundler', '~> 1.12'
end
