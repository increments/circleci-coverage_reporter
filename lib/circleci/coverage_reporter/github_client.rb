require_relative 'abstract_vcs_client'
require_relative 'errors'

module CircleCI
  module CoverageReporter
    class GitHubClient < AbstractVCSClient
      # @note Implement {AbstractVCSClient#create_comment}
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
