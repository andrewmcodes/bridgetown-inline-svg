require "spec_helper"
require "nokogiri"

describe(BridgetownInlineSvg) do
  def read(file)
    File.read(dest_dir(file))
  end

  # return an array of the page's svgs
  def parse(file)
    Nokogiri::HTML(read(file))
  end

  [
    Bridgetown.configuration({
      "svg" => {"optimize" => true},
      "full_rebuild" => true,
      "root_dir" => root_dir,
      "source" => source_dir,
      "destination" => dest_dir
    }),
    Bridgetown.configuration({
      "full_rebuild" => true,
      "root_dir" => root_dir,
      "source" => source_dir,
      "destination" => dest_dir
    })
  ].each do |config|
    (is_opt = config["svg"]) && (config["svg"]["optimize"] == true)

    describe "Integration - #{is_opt ? "with" : "without"} optimization -" do
      before(:context) do
        site = Bridgetown::Site.new(config)
        site.process
        @text = read("index.html")
        @data = parse("index.html")
        @base = @data.css("#base").css("svg").first
      end

      it "render site" do
        expect(File.exist?(dest_dir("index.html"))).to eq(true)
      end

      it "exports svg" do
        data = @data.xpath("//svg")
        expect(data).to be_truthy
        expect(data.first).to be_truthy
        expect(@base).to be_truthy
        # Do not strip other width and height attributes
      end

      it "add a height if only width is given" do
        data = @data.css("#height").css("svg")
        expect(data).to be_truthy
        expect(data[0].get_attribute("height")).to eql("24")
        expect(data[0].get_attribute("width")).to eql("24")
        # do not set height if given
        expect(data[1].get_attribute("height")).to eql("48")
        expect(data[1].get_attribute("width")).to eql("24")
        # do not set height if forced to empty string
        expect(data[2].get_attribute("height")).to is_opt ? be_falsy : eql("")
      end

      context "when liquid arguments (e.g. 'width: 24') are present" do
        subject { @data.css("#liquid-arguments").css("svg") }

        it "renders SVGs" do
          expect(subject.count).to eq(2)
        end

        it "gives precedence to the equals arguments" do
          expect(subject[1].get_attribute("width")).to eql("48")
        end
      end

      it "keep attributes" do
        data = @data.css("#attributes").css("svg")
        expect(data).to be_truthy
        expect(data[0].get_attribute("role")).to eql("navigation")
        expect(data[0].get_attribute("data-foo")).to eql("bar")
        expect(data[0].get_attribute("fill")).to eql("#ffffff")
        expect(data[0].get_attribute("stroke")).to eql("#000000")
      end

      it "parse relative paths" do
        data = @data.css("#path").css("svg")
        expect(data.size).to eq(2)
        expect(data[0].to_html).to eq(data[1].to_html) # should use to_xml?
      end

      it "jails to Bridgetown source" do
        data = @data.css("#jail").css("svg")
        ref = @base.to_xml
        expect(data.size).to eq(2)
        data.each { |item| expect(item.to_xml).to eql(ref) }
      end

      it "interpret variables" do
        data = @data.css("#interpret").css("svg")
        ref = @base.to_xml
        expect(data.size).to eq(3)
        expect(data[0].to_xml).to eql(ref)
        expect(data[1].get_attribute("id")).to eql("name-square")
        expect(data[1].get_attribute("class")).to eql("class-hello")
        expect(data[2].get_attribute("class")).to eql("hyphens-var-test")
      end

      it "#{is_opt ? "do" : "do not"} optimize" do
        data = @data.css("#optimize").css("svg")
        expect(data.first.get_attribute("data-foo")).to is_opt ? be_falsy : eql("")
        expect(data.xpath("//comment()").first).to is_opt ? be_falsy : be_truthy
      end

      it "don't add <?xml> junk" do
        expect(@text).not_to include("<?xml")
      end
    end
  end
end
