require 'ffaker'

require 'circleci/coverage_reporter/artifact'

module CircleCI::CoverageReporter
  ::RSpec.describe(Artifact) do
    let(:artifact) do
      described_class.new(path, url, node_index)
    end

    let(:path) do
      url.split(':/').last
    end

    let(:url) do
      FFaker::Internet.http_url
    end

    let(:node_index) do
      rand(10)
    end

    %w[path url].each do |attr_name|
      describe "##{attr_name}" do
        subject do
          artifact.public_send(attr_name)
        end

        it 'returns the corresponding constructor parameter' do
          should eq public_send(attr_name)
        end
      end
    end

    describe '#match?' do
      subject do
        artifact.match?(value, node_index: node_index_param)
      end

      context 'when the path ends with the given value' do
        let(:value) do
          path[-6..-1]
        end

        context 'and node_index param is not given' do
          let(:node_index_param) do
            nil
          end

          it { should be true }
        end

        context 'and matching node_index param is given' do
          let(:node_index_param) do
            node_index
          end

          it { should be true }
        end

        context 'and nonmatching node_index param is given' do
          let(:node_index_param) do
            node_index + 1
          end

          it { should be false }
        end
      end

      context 'otherwise' do
        let(:value) do
          path[-6..-1] + 'foo'
        end

        context 'and node_index param is not given' do
          let(:node_index_param) do
            nil
          end

          it { should be false }
        end

        context 'and matching node_index param is given' do
          let(:node_index_param) do
            node_index
          end

          it { should be false }
        end

        context 'and nonmatching node_index param is given' do
          let(:node_index_param) do
            node_index + 1
          end

          it { should be false }
        end
      end
    end

    describe '#body' do
      subject do
        artifact.body
      end

      before do
        response = double('faraday', body: body)
        allow(::CircleCI::CoverageReporter.client).to receive(:get).with(url).and_return(response)
      end

      let(:body) do
        FFaker::Lorem.sentence
      end

      it 'returns API response body' do
        should eq body
      end
    end
  end
end
