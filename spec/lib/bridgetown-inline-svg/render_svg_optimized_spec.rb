require "spec_helper"

describe BridgetownInlineSvg::RenderSvgOptimized do
  let(:file_path) { source_dir("images", "square.svg") }
  let(:attributes) { {} }
  let(:instance_class) { described_class.new(file_path, attributes) }

  describe "#call" do
    subject { instance_class.call }

    it "renders a SVG" do
      is_expected.to start_with("<svg")
    end
  end
end
