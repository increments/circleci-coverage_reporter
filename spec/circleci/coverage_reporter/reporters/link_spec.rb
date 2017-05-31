require 'digest/sha1'
require 'ffaker'
require 'fileutils'

require 'circleci/coverage_reporter/reporters/link'
require 'circleci/coverage_reporter/build'

module CircleCI::CoverageReporter
  ::RSpec.describe(Reporters::Link) do
    let(:link) do
      described_class.new(path: path, name: name)
    end

    let(:path) do
      'doc/index.html'
    end

    let(:name) do
      'YARD'
    end

    describe '#name' do
      it 'returns its name constructor parameter' do
        expect(link.name).to eq name
      end
    end

    describe '#active?' do
      subject do
        link.active?
      end

      context 'when there is a file' do
        before do
          full_path = File.join(CircleCI::CoverageReporter.configuration.artifacts_dir, path)
          FileUtils.mkdir_p(File.dirname(full_path))
          FileUtils.touch(full_path)
        end

        it { should be true }
      end

      context 'otherwise' do
        it { should be false }
      end
    end

    describe '#report' do
      subject do
        link.report(base_build, previous_build)
      end

      def prepare_build_object
        artifact = double('Artifact', url: FFaker::Internet.http_url)
        build = double('Build', vcs_revision: ::Digest::SHA1.hexdigest(rand.to_s), build_number: rand(100))
        allow(build).to receive(:find_artifact).and_return(artifact)
        build
      end

      shared_context 'base_build is given' do |actual|
        let(:base_build) do
          actual ? prepare_build_object : nil
        end
      end

      shared_context 'previous_build is given' do |actual|
        let(:previous_build) do
          actual ? prepare_build_object : nil
        end
      end

      shared_examples 'returns a LinkReport' do
        it 'returns a LinkReport' do
          should be_a Reporters::Link::LinkReport
          expect(subject.to_s).to be_a String
        end
      end

      context 'both base_build and previous_build are not given' do
        include_context 'base_build is given', false
        include_context 'previous_build is given', false
        include_examples 'returns a LinkReport'
      end

      context 'base_build is given but previous_build is not' do
        include_context 'base_build is given', true
        include_context 'previous_build is given', false
        include_examples 'returns a LinkReport'
      end

      context 'previous_build is given but base_build is not' do
        include_context 'base_build is given', false
        include_context 'previous_build is given', true
        include_examples 'returns a LinkReport'
      end

      context 'both base_build and previous_build are given' do
        include_context 'base_build is given', true
        include_context 'previous_build is given', true
        include_examples 'returns a LinkReport'
      end
    end
  end
end
