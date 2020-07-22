shared_examples "RenderSvg" do
  describe "#call" do
    subject { instance_class.call }

    it "renders a SVG" do
      is_expected.to start_with("<svg")
    end

    it "strips XML decoration" do
      is_expected.to_not include("<?xml")
    end

    it "keeps existing SVG attributes" do
      is_expected.to include("width=\"150\"")
      is_expected.to include("height=\"150\"")
    end

    context "given attributes which override the svg values" do
      let(:attributes) { { width: 10, height: 10 } }

      it { is_expected.to include("width=\"10\"") }
      it { is_expected.to include("height=\"10\"") }
    end

    context "given attributes which add new attributes to the svg" do
      let(:attributes) { { "data-attribute": "Sample" } }

      it { is_expected.to include("data-attribute=\"Sample\"") }
    end
  end
end
