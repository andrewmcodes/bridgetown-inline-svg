require "spec_helper"

describe BridgetownInlineSvg::Attributes do
  describe "::parse" do
    subject { described_class.parse(markup) }
    let(:svg) { svg, _params = subject; svg }
    let(:params) { _svg, params = subject; params }

    context "with invalid syntax" do
      let(:markup) { "" }
      it { expect { subject }.to raise_error(SyntaxError) }
    end

    context "parse XML root parameters" do
      let(:markup) { "/path/to/foo size=40 style=\"hello\"" }

      it do
        expect(svg).to eq("/path/to/foo")
        expect(params).to eq("size=40 style=\"hello\"")
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

    context "don't parse parameters" do
      let(:markup) { "'/path/to/foo space' id='bar' style=\"hello\"" }
      it { expect(params).to eq("id='bar' style=\"hello\"") }
    end
  end
end
