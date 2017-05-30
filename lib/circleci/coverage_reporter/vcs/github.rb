require 'faraday'

require_relative '../errors'
require_relative 'base'

module CircleCI
  module CoverageReporter
    module VCS
      class GitHub < Base
        # @note Implement {Base#create_comment}
        # @param body [String]
        # @return [void]
        # @raise [RequestError]
        def create_comment(body)
          resp = request(body)
          raise RequestError.new(JSON.parse(resp.body)['message'], resp) unless resp.success?
        end

        private

        # @param body [String]
        # @return [Faraday::Response]
        def request(body)
          Faraday.new(url: 'https://api.github.com').post do |req|
            req.url ['/repos', configuration.project, 'commits', configuration.current_revision, 'comments'].join('/')
            req.headers['Authorization'] = "token #{token}"
            req.headers['Content-Type'] = 'application/json'
            req.body = JSON.generate(body: body)
          end
        end

        # @return [Configuration]
        def configuration
          CoverageReporter.configuration
        end
      end
    end
  end
end
