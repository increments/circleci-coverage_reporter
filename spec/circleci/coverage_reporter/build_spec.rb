require 'digest/sha1'

require 'circleci/coverage_reporter/build'

module CircleCI::CoverageReporter
  ::RSpec.describe(Build) do
    let(:build) do
      described_class.new(vcs_revision, build_number)
    end

    let(:vcs_revision) do
      ::Digest::SHA1.hexdigest(rand.to_s)
    end

    let(:build_number) do
      rand(100)
    end

    %w[vcs_revision build_number].each do |attr_name|
      describe "##{attr_name}" do
        subject do
          build.public_send(attr_name)
        end

        it 'returns the corresponding constructor parameter' do
          should eq public_send(attr_name)
        end
      end
    end

    describe '#match?' do
      subject do
        build.match?(revision)
      end

      context 'when same string is given' do
        let(:revision) do
          vcs_revision
        end

        it { should be true }
      end

      context 'when vcs_revision attribute starts with the given string' do
        let(:revision) do
          vcs_revision[0..7]
        end

        it { should be true }
      end

      context 'otherwise' do
        let(:revision) do
          'something'
        end

        it { should be false }
      end
    end

    describe '#artifacts' do
      subject do
        build.artifacts
      end

      it 'delegates to Client#artifacts' do
        artifacts = double
        allow(::CircleCI::CoverageReporter.client).to receive(:artifacts).with(build_number).and_return(artifacts)
        should eq artifacts
      end
    end

    describe '#find_artifact' do
      subject do
        build.find_artifact('query')
      end

      context 'when #articles is empty' do
        before do
          allow(build).to receive(:artifacts).and_return([])
        end

        it { should be_nil }
      end

      context 'when #articles is present' do
        before do
          allow(build).to receive(:artifacts).and_return([artifact])
        end

        let(:artifact) do
          double
        end

        context 'and no artifact matches to the given string' do
          before do
            allow(artifact).to receive(:match?).and_return(false)
          end

          it { should be_nil }
        end

        context 'and an artifact matches to the given string' do
          before do
            allow(artifact).to receive(:match?).and_return(true)
          end

          it { should eq artifact }
        end
      end
    end
  end
end
