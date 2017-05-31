require 'fileutils'

require 'circleci/coverage_reporter/reporters/link'

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

      let(:base_build) do
        nil
      end

      let(:previous_build) do
        nil
      end

      it { should be_a Reporters::Link::LinkReport }
    end
  end
end
