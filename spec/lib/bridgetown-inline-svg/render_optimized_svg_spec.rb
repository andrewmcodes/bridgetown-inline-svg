require "spec_helper"

describe BridgetownInlineSvg::RenderOptimizedSvg do
  let(:file_path) { source_dir("images", "square.svg") }
  let(:attributes) { {} }
  let(:instance_class) { described_class.new(file_path, attributes) }

  it_behaves_like "RenderSvg"
end
