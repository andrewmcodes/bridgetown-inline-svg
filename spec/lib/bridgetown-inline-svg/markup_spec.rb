require "spec_helper"

describe BridgetownInlineSvg::Markup do
  describe "::parse" do
    subject { described_class.parse(markup) }
    let(:svg) do
      svg, _params = subject
      svg
    end
    let(:params) do
      _svg, params = subject
      params
    end

    context "with invalid syntax" do
      let(:markup) { "" }
      it { expect { subject }.to raise_error(SyntaxError) }
    end

    context "parse parameters" do
      let(:markup) { "/path/to/foo size=40 style=\"hello\"" }

      it do
        expect(svg).to eq("/path/to/foo")
        expect(params).to eq({size: "40", style: "hello"})
      end
    end

    context "accepts double quoted path" do
      let(:markup) { "\"/path/to/foo space\"" }
      it { expect(svg).to eq("/path/to/foo space") }
    end

    context "accepts single quoted path" do
      let(:markup) { "'/path/to/foo space'" }
      it { expect(svg).to eq("/path/to/foo space") }
    end

    context "strip leading and trailing spaces" do
      let(:markup) { " /path/to/foo " }
      it { expect(svg).to eq("/path/to/foo") }
    end

    # required when a variable is defined with leading/trailing space then embedded.
    context "strip in-quote leading and trailing spaces" do
      let(:markup) { "'/path/to/foo '" }
      it { expect(svg).to eq("/path/to/foo") }
    end

    context "keep Liquid variables" do
      let(:markup) { "/path/to/{{foo}}" }
      it { expect(svg).to eql("/path/to/{{foo}}") }
    end

    context "parses parameters into a hash" do
      let(:markup) { "'/path/to/foo space' id='bar' style=\"hello\"" }
      it { expect(params).to eq({id: "bar", style: "hello"}) }
    end

    context "includes hashes within params" do
      let(:markup) { "svg images/square.svg  role=\"navigation\" data-foo=\"bar\" fill=\"#ffffff\" stroke=#000000" }
      it { expect(params).to eq({"data-foo": "bar", fill: "#ffffff", role: "navigation", stroke: "#000000"}) }
    end

    context "parse Liquids colon seperated variables" do
      let(:markup) { "'/path/to/foo space' width: 25 height:20 decimal: 20.20 id='sample-id'" }
      it { expect(params).to eq({width: "25", decimal: "20.20", height: "20", id: "sample-id"}) }
    end
  end
end
