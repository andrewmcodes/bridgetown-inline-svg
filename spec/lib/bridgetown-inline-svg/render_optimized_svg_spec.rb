require "spec_helper"

describe BridgetownInlineSvg::RenderOptimizedSvg do
  let(:file_path) { source_dir("images", "square.svg") }
  let(:attributes) { {} }
  let(:instance_class) { described_class.new(file_path, attributes) }

  it_behaves_like "RenderSvg"

  describe "#call" do
    subject { instance_class.call }

    it "removes comment within SVG" do
      expect(subject).to_not include('<!-- comment -->')
    end
  end
end
